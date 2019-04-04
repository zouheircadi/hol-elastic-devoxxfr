# Hand On Lab Devoxx France 2019-04
## Recherches full-text
### 3.4 Proximité
### 3.4.1 Phrase match

##### 3.4.1.1 Création index de travail

```shell     
POST /hol_devoxxfr_mp1/_doc/_bulk
{ "index": { "_id": 1 }}
{ "title": "Je ne suis pas content. Service client nul" }
{ "index": { "_id": 2 }}
{ "title": "Je suis content. Pas de retard de livraison" }
{ "index": { "_id": 3 }}
{ "title": "Je suis tres content. pas de probleme" }
```


##### 3.4.1.2 Analyse des données indexées
###### Mettez en évidence cet ordre avec le champ title du document d’identifiant 3.


Si vous avez fait l'exercice 2.1, vous l'avez déjà utilisé. Il s'agit de la requête sur le endpoint _analyze [indiquée en annexe](https://docs.google.com/document/d/1wZqOUP7X6eSZl7jMz7YXJbKT8EkNI30ZxlyYU3vqsCE/edit#heading=h.46n4fb7pm59).


```shell     
GET /hol_devoxxfr_mp1/_analyze
{
  "field": "app_name",
  "text" : "Je suis tres content. pas de probleme"
}
```

Le résultat donne la position de chaque token. Cette information est donc connue car stockée lors de l'indexation.

```json
{
  "tokens" : [
    {
      "token" : "je",
      "start_offset" : 0,
      "end_offset" : 2,
      "type" : "<ALPHANUM>",
      "position" : 0
    },
    {
      "token" : "suis",
      "start_offset" : 3,
      "end_offset" : 7,
      "type" : "<ALPHANUM>",
      "position" : 1
    },
    {
      "token" : "tres",
      "start_offset" : 8,
      "end_offset" : 12,
      "type" : "<ALPHANUM>",
      "position" : 2
    },
    {
      "token" : "content",
      "start_offset" : 13,
      "end_offset" : 20,
      "type" : "<ALPHANUM>",
      "position" : 3
    },
    {
      "token" : "pas",
      "start_offset" : 22,
      "end_offset" : 25,
      "type" : "<ALPHANUM>",
      "position" : 4
    },
    {
      "token" : "de",
      "start_offset" : 26,
      "end_offset" : 28,
      "type" : "<ALPHANUM>",
      "position" : 5
    },
    {
      "token" : "probleme",
      "start_offset" : 29,
      "end_offset" : 37,
      "type" : "<ALPHANUM>",
      "position" : 6
    }
  ]
}
```

##### 3.4.1.3 match ou match_phrase

###### Faites la requête
```shell
GET /hol_devoxxfr_mp1/_search
{
  "query": 
  {
    "match": {
      "title": "pas content"
    }
  }
}
```

###### Que pensez vous de la pertinence du résultat ?
C'est le score des documents retournés qui nous donne une indication de la pertinence des résultats (voir ci-dessous le json simplifié retourné par la requête).
On constate ainsi que la distinction entre les utilisateurs content et pas content n'est pas bien reflétée par une différence de score.

```json
{
  "hits" : [
    {
      "_score" : 0.27691346,
      "_source" : {
        "title" : "Je suis tres content. pas de probleme"
      }
    },
    {
      "_score" : 0.26239565,
      "_source" : {
        "title" : "Je ne suis pas content. Service client nul"
      }
    },
    {
      "_score" : 0.26239565,
      "_source" : {
        "title" : "Je suis content. Pas de retard de livraison"
      }
    }
  ]
}
```


###### Faites la requête sur les mêmes tokens mais avec une query de type match_phrase. Comparez le résultat obtenu avec le résultat précédent.
Requête match_phrase avec la chaîne "pas content".
Cette requête ne retourne qu'un seul document. 
* Avantage. Elle prend en compte l'ordre des tokens (pas content) qui induit du sens
* Inconvénient. Elle est trop restricitive

```shell
Requête multimatch avec la chaîne "pas content"
GET /hol_devoxxfr_mp1/_search
{
  "query": 
  {
    "match_phrase": 
    {
      "title" : "pas content"
    }
  }
}
```


##### 3.4.1.4 Match phrase avec slop 

```shell
GET /hol_devoxxfr_mp1/_search
{
  "query": 
  {
    "match_phrase": 
    {
      "title" : 
      {
        "query": "pas content",
        "slop" : "2"
      }
    }
  }
}
```
Avec une slop de 2, on trouve tous les documents. Mais le document avec les tokens en bonne position à un score à peu près égal au double de celui des autres documents.

Dans la pratique, on passe souvent en paramètre une slop élevée (entre 50 et 100) de manière à récompenser les documents avec des mots proches de la requêtes et à exclure les documents trop éloignés 