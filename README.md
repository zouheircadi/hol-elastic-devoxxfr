# Hand On Lab Devoxx France 2019-04
# 2. Recherches
## 2.4 Partial matching
### 2.4.3 Partial matching avec modification de l’indexation : edge-ngrams
###### En vous aidant de la documentation en ligne, créer un index de type index-time-search-as-you-type que vous appellerez hol_devoxxfr_pm3

```shell
DELETE hol_devoxxfr_pm3
```

```shell
PUT /hol_devoxxfr_pm3
{
  "settings": 
  {
    "analysis": 
    {
      "filter": 
      {
        "ac_filter": 
        {
          "type": "edge_ngram",
          "min_gram": 1,
          "max_gram": 20
        }
      },
      "analyzer": 
      {
        "ac_analyzer": 
        {
          "type": "custom",
          "tokenizer": "standard",
          "filter": 
          [
            "lowercase",
            "ac_filter"
          ]
        }
      }
    }    
  }, 
  "mappings": 
  {
    "_doc" :
    {
      "properties" : 
      {
        "code" : 
        {
          "type" : "keyword"
        },
        "country" :
        {
          "type" : "text",
          "fields": 
          {
            "keyword": 
            {
              "type": "keyword"
            },
            "autocomplete": 
            {
              "type": "text",
              "analyzer" : "ac_analyzer",
              "search_analyzer" : "standard"
            }            
          }
        }
      }
    }
  }
}
```


###### Charger les données dans l’index nouvellement créé.
```shell
./data/post-data-3-curl.sh
```

###### Tester le nouvel index en cherchant le token “rep”

```shell
GET hol_devoxxfr_pm3/_search
{
  "query": 
  {
    "match": {
      "country.autocomplete": "repu"
    }
  }
}
```
