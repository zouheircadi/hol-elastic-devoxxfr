# Hand On Lab Devoxx France 2019-04
## 2.2 Recherches full-text
### 2.2.3 Recherches multichamps - un texte commun à tous les champs


##### 2.2.3.1 Recherches de type booléen
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


##### 2.2.3.2 Effets de bord du mode précédent
On recherche les tokens "draw art" dans les documents ci-dessous

```shell
POST /hol_devoxxfr_gstore_322/_doc/_bulk
{ "index": { "_id": 1 }}
{"genres" : "Entertainment", "app_name" : "Pixel Draw Art filter for selfies"}
{ "index": { "_id": 2 }}
{"genres" : "Art", "app_name" : "Pixel Draw"}
```

```json
GET /hol_devoxxfr_gstore_322/_search
{
 "query": {
   "bool": {
     "should": [
       {"match": {"genres": "draw art"}},
       {"match": {"app_name": "draw art"}}
     ]
   }
 }
}
```



Les tokens draw et art sont présents
* Pour le document d’identifiant 1, simultanément dans le champs app_name. Ce document peut donc être considéré comme très pertinent en prenant comme hypothèse que l’association et la proximité des mots est importante
* Pour le document d’identifiant 2, art est présent dans le champ genres et draw est présent dans le champ app_name. Le mode de calcul de la pertinence lui attribue  ainsi un score plus élevé.

On peut ne pas se satisfaire de ce mode de calcul. Comment faire pour que les champs qui contiennent le plus de mots recherchés remontent mieux ? La réponse est dans l’exercice suivant.


###### 2.2.3.3 Recherches de type Dismax

```json
GET /hol_devoxxfr_gstore_322/_search
{
 "query":
 {
   "dis_max": {
     "queries":
     [
       {"match": {"genres": "art draw"}},
       {"match": {"app_name": "art draw"}}
     ]
   }
 }
}
```


###### 2.2.3.4 Recherches de type Dismax  - effet de bord

```json
POST /hol_devoxxfr_gstore_323/_doc/_bulk
{ "index": { "_id": 1 }}
{"genres" : "Art", "app_name" : "Pixel Draw Number"}
{ "index": { "_id": 2 }}
{"genres" : "Entertainment", "app_name" : "Pixel Draw Art number"}
```



```json
GET /hol_devoxxfr_gstore_323/_search
{
 "query":
 {
   "dis_max": {
     "queries":
     [
       {"match": {"genres": "entertainment art"}},
       {"match": {"app_name": "entertainment art"}}
     ]
   }
 }
}
```

Le document 2 contient le terme entertainment dans le champ genres et le terme art dans le champ app_name. Il est donc plus pertinent que le document 1 qui ne contient que le terme art dans le champ genres. Or, comme la requête est de type Dismax, seul le score du champ qui matche le mieux est remonté pour un document donné ; le score des autres champs qui matchent n’est pas pris en compte. L’effet cumulatif sur le score en cas de présence simultanée dans plusieurs champs est donc perdu.

La solution pour tenir compte de tous les champs qui matchent est expliquée dans l’exercice suivant



###### 2.2.3.5 Recherches de type Dismax  avec tiebreaker

```json
GET /hol_devoxxfr_gstore_323/_search
{
 "query":
 {
   "dis_max": {
     "queries":
     [
       {"match": {"genres": "entertainment art"}},
       {"match": {"app_name": "entertainment art"}}
     ],
     "tie_breaker": 0.3
   }
 }
}
```


###### 2.2.3.6 Comprendre le score du mode Dismax

Pour décomposer le score, il faut faire un explain comme indiqué ci-dessous

 * Pour tous les documents

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
      "tie_breaker": 0.3
    }
  }
}
```

* Pour le document d'identifiant 2
```json
GET /hol_devoxxfr_gstore_323/_doc/2/_explain
{
  "query": 
  {
    "dis_max": {
      "queries": 
      [
        {"match": {"genres": "entertainment art"}},
        {"match": {"app_name": "entertainment art"}}        
      ],
      "tie_breaker": 0.3
    }
  }
}
```

Le score se décompose comme suit :
* 0.88960975 = 
    * 0,6931472 => le tie_breaker ne s'applique pas au champ dont le score est le plus élevé
    *    (+) 
    * (tie_breaker * 0,6548752)  => prise en compte du champ de score plus bas modéré par le tie_breaker

Modulation de l'effet tie_breaker 
* tie_breaker = 0 : le score du document remonté sera celui du champ dont le score est le plus élevé
* tie_breaker = 1 : Suppression de l'effet Dismax 
* tie_breaker usuel 0.3 à 0.4

#### 2.2.3.7 Queries de type Multimatch

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

#### 2.2.3.8 Multimatch avec pondération de champs

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

