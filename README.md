# Hand On Lab Devoxx France 2019-04
## Les filtres (recherches structurées)
### 2.2 


###### Données à charger avec les devTools Kibana
```shell
POST hol_devoxxfr_filter/_doc/_bulk
{ "index": { "_id": 1 }}
{"app_name" : "Photo Editor & Candy Camera & Grid & ScrapBook", "type" : "Free", "genres" : "Art & Design", "category" : "ART_AND_DESIGN","price" : 0.0, "last_updated" : "2018-01-06T23:00:00.000Z", "content_rating" : "Everyone","rating" : 4.1}
{ "index": { "_id": 2 }}
{ "app_name" : "Pixel Draw - Number Art Coloring Book", "type" : "Free", "genres" : "Art & Design;Creativity", "category" : "ART_AND_DESIGN",           "price" : 0.0, "last_updated" : "2018-06-19T22:00:00.000Z", "content_rating" : "Everyone", "rating" : 4.3}
{ "index": { "_id": 3 }}
{ "app_name" : "Garden Coloring Book", "type" : "Free", "genres" : "Art & Design", "category" : "ART_AND_DESIGN", "price" : 0.0, "last_updated" : "2017-09-19T22:00:00.000Z", "content_rating" : "Everyone", "rating" : 4.4}
{ "index": { "_id": 4 }}
{ "app_name" : "Tattoo Name On My Photo Editor", "type" : "Free", "genres" : "Art & Design", "category" : "ART_AND_DESIGN",           "price" : 0.0, "last_updated" : "2018-04-01T22:00:00.000Z", "content_rating" : "Teen", "rating" : 4.2}
{ "index": { "_id": 5 }}      
{ "app_name" : "YouTube Kids", "type" : "Free", "genres" : "Entertainment;Music & Video", "category" : "FAMILY",           "price" : 0.0, "last_updated" : "2018-08-02T22:00:00.000Z", "content_rating" : "Everyone", "rating" : 4.5}
{ "index": { "_id": 6 }}      
{ "app_name" : "Candy Bomb", "type" : "Free", "genres" : "Casual;Brain Games", "category" : "FAMILY",           "price" : 0.0, "last_updated" : "2018-07-03T22:00:00.000Z", "content_rating" : "Everyone", "rating" : 4.4}
{ "index": { "_id": 7 }}      
{ "app_name" : "ROBLOX", "type" : "Free", "genres" : "Adventure;Action & Adventure", "category" : "FAMILY",           "price" : 0.0, "last_updated" : "2018-07-30T22:00:00.000Z", "content_rating" : "Everyone 10+", "rating" : 4.5}
{ "index": { "_id": 8 }}      
{ "type" : "Free", "genres" : "Casual;Brain Games", "category" : "FAMILY",           "price" : 0.0, "last_updated" : "2018-07-22T22:00:00.000Z", "content_rating" : "Everyone", "rating" : 4.4}
{ "index": { "_id": 9 }}      
{ "app_name" : "Bowmasters", "type" : "Free", "genres" : "Action", "category" : "GAME",           "price" : 0.0, "last_updated" : "2018-07-22T22:00:00.000Z", "content_rating" : "Teen", "rating" : 4.7}
{ "index": { "_id": 10 }}      
{ "app_name" : "Magic Tiles 3", "@timestamp" : "2019-03-02T07:03:20.040Z", "type" : "Free", "genres" : "Music", "category" : "GAME", "price" : 0.0, "last_updated" : "2018-08-02T22:00:00.000Z", "content_rating" : "Everyone", "rating" : 4.5}
{ "index": { "_id": 11 }}      
{ "app_name" : "Block Puzzle Classic Legend !", "@timestamp" : "2019-03-02T07:03:20.040Z", "type" : "Free", "genres" : "Puzzle", "category" : "GAME",           "price" : 0.0, "last_updated" : "2018-04-12T22:00:00.000Z", "content_rating" : "Everyone", "rating" : 4.2}
{ "index": { "_id": 12 }}      
{ "app_name" : "Marble Woka Woka 2018 - Bubble Shooter Match 3", "type" : "Free", "genres" : "Puzzle", "category" : "GAME",           "price" : 0.0, "last_updated" : "2018-08-02T22:00:00.000Z", "content_rating" : "Everyone", "rating" : 4.6}
{ "index": { "_id": 13 }}      
{ "app_name" : "QR Code Reader", "type" : "Free", "genres" : "Tools", "category" : "TOOLS",           "price" : 0.0, "last_updated" : "2016-03-15T23:00:00.000Z", "content_rating" : "Everyone", "rating" : 4.0}
{ "index": { "_id": 14 }}      
{ "app_name" : "SHAREit - Transfer & Share", "type" : "Free", "genres" : "Tools", "category" : "TOOLS",           "price" : 0.0, "last_updated" : "2018-07-29T22:00:00.000Z", "content_rating" : "Everyone", "rating" : 4.6}
{ "index": { "_id": 15 }}      
{ "app_name" : "Diabetes:M", "type" : "Free", "genres" : "Medical", "category" : "MEDICAL", "price" : 0.0, "last_updated" : "2018-07-31T22:00:00.000Z", "content_rating" : "Everyone", "rating" : 4.6}      
```    

Le mapping est inféré. Notez donc bien le mapping des champs contenant des chaînes de caractères. Nous avons représenté ci-dessous le mapping du champ category. Pour filtrer sur une category, il faut donc utiliser le champ category.keyword qui est de type keyword. Les champs imbriqués sous l'attribut fields sont accédés par cette notation pointée.
```json
"category" : {
"type" : "text",
"fields" : {
  "keyword" : {
    "type" : "keyword",
    "ignore_above" : 256
  }
}      
```    

###### Quels sont tous les documents de la category ART_AND_DESIGN ?

Plusieurs réponses possibles

* Avec une query mixte de type booléen contenant
    * un match_all
    * et un filtre

Le match_all peut être remplacé par une ou des requêtes full text (match, multi_match, ...). Si tel était le cas, le contexte aurait été de type full text avec un calcul de score.
```shell
POST hol_devoxxfr_filter/_search
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
          "category.keyword": "ART_AND_DESIGN"
        }  
  
      }
    }
  }
}
```

* Avec une query de type booléen et un filtre
```shell
POST hol_devoxxfr_filter/_search
{
  "query": 
  {
    "bool": 
    {
      "filter": 
      {
        "term": {
          "category.keyword": "ART_AND_DESIGN"
        }
      }
    }
  }
}
```

* Avec une constant score query
```shell
 GET /hol_devoxxfr_filter/_doc/_search
 {
     "query" : {
         "constant_score" : {
           "filter": 
           {
             "term": {
               "category.keyword" : "ART_AND_DESIGN"
             }
           }
         }
     }
 }
```

###### Quels sont tous les documents pour lesquels le champ date  last_updated est compris entre 2017-01-01 et 2017-12-31 (les documents de 2017 en somme) ?
```shell
POST hol_devoxxfr_filter/_search
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
        "range": {
          "last_updated": {
            "gte": "2017-01-01",
            "lte": "2017-12-31"
          }
        }
      }
    }
  }
}
```

###### Quels sont les documents dont le rating est strictement supérieur à 4.6 ?
```shell
POST hol_devoxxfr_filter/_search
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
        "range": {
          "rating": {
            "gt": "4.6"
          }
        }
      }
    }
  }
}
```