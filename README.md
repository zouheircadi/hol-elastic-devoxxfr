# Hand On Lab Devoxx France 2019-04
## Les filtres (recherches structurées)
### 2.1 Recherche basique de type filtre


###### Trouver le document dont la category est exactement "ART-AND-DESIGN"
```shell
GET /hol_devoxxfr_11/_doc/_search
{
    "query" : {
        "constant_score" : {
          "filter": 
          {
            "term": {
              "category" :"ART-AND-DESIGN"
            }
          }
        }
    }
}
```    

###### Pour quelle raison
L'API analyse nous indique que le champ n'est pas indexé tel quel. Il est tokenisé sur le tiret. Il n'est donc pas possible de le trouver  
```shell
GET /hol_devoxxfr_11/_analyze
{
  "field" : "category",  
  "text" : "ART-AND-DESIGN"
}
```

Si on effectue le même test sur le champ category.keyword, on constate que le document est indexé tel quel
```shell
GET /hol_devoxxfr_11/_analyze
{
  "field" : "category.keyword",  
  "text" : "ART-AND-DESIGN"
}
```

Lorsqu'on utilise le "mapping automatique", tout champ de type texte est indexé de deux manières 
* Indexation de type text => Le champ est analysé
* Indexation de type keyword => Le champ n'est pas analysé. Il est indexé sans aucune modification
Pour l'index hol_devoxxfr_11, on peut donc interroger le champ category.keyword
```shell
GET /hol_devoxxfr_11/_doc/_search
{
    "query" : {
        "constant_score" : {
          "filter": 
          {
            "term": {
              "category.keyword" :"ART-AND-DESIGN"
            }
          }
        }
    }
}
```

Pour l'index hol_devoxxfr_14, on peut donc interroger le champ category pur lequel on a fixer le mapping
```shell
GET /hol_devoxxfr_14/_doc/_search
{
    "query" : {
        "constant_score" : {
          "filter": 
          {
            "term": {
              "category" :"ART-AND-DESIGN"
            }
          }
        }
    }
}
```