# Hand On Lab Devoxx France 2019-04
## Les filtres (recherches structurées)
### 2.1 Recherche basique de type filtre


###### Trouver le document dont la category est exactement "ART-AND-DESIGN"

Les trois requêtes ci-dessous de type filtre ne retournent aucun résultat
* constant score query
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

* boolean query
```shell
GET /hol_devoxxfr_11/_search
{
  "query": 
  {
    "bool": 
    {
      "filter": 
      {
        "term": {
          "category": "ART-AND-DESIGN"
        }
      }
    }
  }
}
```

* boolean mixte query
```shell
GET /hol_devoxxfr_11/_search
{
  "query": 
  {
    "bool": 
    {
      "should": 
      [
        {"match_all": {}}
      ],
      "filter": 
      {
        "term": {
          "category": "ART-AND-DESIGN"
        }
      }
    }
  }
}
```


###### Pour quelle raison  ?

* on vérifie dans un premier temps que l'index contient bien des données

```shell
GET /hol_devoxxfr_11/_search
```

* On utilise ensuite le endPoint _analyze pour voir comment est indexé le champ  
```json
GET /hol_devoxxfr_11/_analyze
{
  "field" : "category",  
  "text" : "ART-AND-DESIGN"
}
```

L'API analyse nous indique que le champ n'est pas indexé tel quel. Il est tokenisé sur le tiret. Il n'est donc pas possible de le trouver

Si on effectue le même test sur le champ category.keyword, on constate que le contenu du champ est indexé tel quel
```json
GET /hol_devoxxfr_11/_analyze
{
  "field" : "category.keyword",  
  "text" : "ART-AND-DESIGN"
}
```


###### Quelle(s) solution(s) peut-on envisager pour remédier à cette situation ?

* index hol_devoxxfr_11
    * Lorsqu'on utilise le "mapping automatique", tout champ de type texte est indexé de deux manières 
        * Indexation de type text => Le champ est analysé
        * Indexation de type keyword => Le champ n'est pas analysé. Il est indexé sans aucune modification.
    * Pour l'index hol_devoxxfr_11, on peut donc interroger le champ category.keyword





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

* Pour l'index hol_devoxxfr_14, on peut interroger le champ category pour lequel on a fixé le mapping
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

Il faut donc bien veiller à indexer les chaines de caractère avec le type keyword pour éviter les surprises. Les types primitifs (integer, long, float,double ...) et le type date n'exigent pas de configuration particulière hormis le typage par défaut.
