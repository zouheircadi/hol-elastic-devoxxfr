# Hand On Lab Devoxx France 2019-04
## Recherches full-text
### 3.3 Recherches multichamps - un texte commun à tous les champs


##### 3.3.1 Recherches de type booléen
* Trouver les documents qui contiennent
    * "draw art" dans le champ app_name
    * "draw art" dans le champ genres

```shell      
GET  hol_devoxxfr_gstore_320/_search
{
  "query": 
  {
    "bool": 
    {
      "should": 
      [
        {"match": {"app_name": "draw art"}},
        {"match": {"genres": "draw art"}}
      ]  
    }
  }
}
```


##### 3.3.2 Effets de bord du mode précédent
On recherche les tokens "draw art" dans les documents ci-dessous

```json
{ "index": { "_id": 1 }}
{"app_name" : "draw pixel art number", "genres" : "Art & Design;Creativity"}
{ "index": { "_id": 2 }}
{"app_name" : "draw pixel number", "genres" : "Art & Design"}
{ "index": { "_id": 3 }}
{"app_name" : "draw figure", "genres" : "Art & Design"}
```

Les tokens draw et art sont présents
* Pour le document d’identifiant 1, simultanément dans le champs app_name. Ce document peut donc être considéré comme pertinent en prenant comme hypothèse que l’association et la proximité des mots est importante
* Pour le document d’identifiant 2, art est présent dans le champ genres et draw est présent dans le champ app_name. Le mode de calcul de la pertinence lui attribue  ainsi un score plus élevé.

On peut ne pas se satisfaire de ce mode de calcul. Comment faire pour que les champs qui contiennent le plus de mots recherchés remontent mieux ? La réponse est dans l’exercice suivant.


###### 3.3.3 Recherches de type Dismax



###### 3.3.4 Recherches de type Dismax  - effet de bord



###### 3.3.5 Recherches de type Dismax  avec tiebreaker



###### 3.3.6 Comprendre le score du mode Dismax

```shell      
GET /hol_devoxxfr_gstore_323/_search?explain=true
{
  "query": 
  {
    "dis_max": {
      "queries": 
      [
        {"match": {"genres": "entertainment art"}},
        {"match": {"app_name": "entertainment art"}}        
      ],
      "tie_breaker": 0.0
    }
  }
}
```

* 0.88960975 = 
    * 0,6931472 => le tie_breaker ne s'applique pas au champ dont le score est le plus élevé
    *    (+) 
    * (tie_breaker * 0,6548752)  => prise en compte du champ de score plus bas modéré par le tie_breaker

* Modulation de l'effet tie_breaker 
    * tie_breaker = 0 : le score du document remonté sera celui du champ dont le score est le plus élevé
    * tie_breaker = 1 : Suppression de l'effet Dismax 
    * tie_breaker usuel 0.3 à 0.4

### 3.1.7 Queries de type Multimatch

```shell      
GET /hol_devoxxfr_gstore_323/_search
{
  "query": 
  {
    "multi_match": {
      "type": "best_fields", 
      "query": "entertainment art",
      "fields": ["genres","app_name"],
      "tie_breaker": 0.3
      
    }
  }
}
```

Selon, le type choisi (most_fields ou cross_fields), ce type de requête propose [d’autres fonctionnalités](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-multi-match-query.html).

### 3.1.8 Multimatch avec pondération de champs

```shell
GET /hol_devoxxfr_gstore_323/_search
{
  "query": 
  {
    "multi_match": {
      "query": "entertainment art",
      "type": "best_fields", 
      "fields": ["genres^0.3","app_name^4"],
      "tie_breaker": 0.3
      
    }
  }
}
```

La pondération est appelée boost est peut être  
* égale à un entier naturel positif. Dans ce cas, elle augmentera le score
* comprise entre 0 et 1. Dans ce cas, elle réduira le score

Il est possible d'appliquer des boosts différents à chaque champ. Dans l'exemple donné, on applique
* un boost de 4 au champ app_name ce qui augmentera son poids dans le score global du document
* un boost de 0.3 au champ genres ce qui diminuera son poids dans le score global du document

