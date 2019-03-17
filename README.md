# Hand On Lab Devoxx France 2019-04
## Gestion des index
### 1.5 Gestion Alias


Créer un premier index en mode autocréation avec la requête ci-dessous
```shell
POST /hol_devoxxfr_151/_doc/_bulk
{ "index": { "_id": 1 }}
{"app_name" : "Photo Editor", "category" : "ART-AND-DESIGN", "last_updated" : "2018-01-06","rating" : 4.1}
{ "index": { "_id": 2 }}
{ "app_name" : "YouTube Kids", "category" : "FAMILY", "last_updated" : "2018-08-02", "rating" : 4.5}
{ "index": { "_id": 3 }}      
{ "app_name" : "Block Puzzle Classic Legend !","category" : "GAME", "last_updated" : "2018-07-22", "rating" : 4.7}
{ "index": { "_id": 4 }}      
{ "app_name" : "Marble Woka Woka 2018 - Bubble Shooter Match 3", "category" : "GAME", "last_updated" : "2018-08-02","rating" : 4.6}
      
```

Vérifier que votre index 
* contient bien un seul shard avec zéro réplica
* que le mapping est différent de celui inféré par défaut



```json
PUT /hol_devoxxfr_14
{
  "mappings": 
  {
    "_doc":
    {
      "properties": 
      {
        "app_name" : {"type": "text"},
        "category" : {"type": "keyword"},
        "last_updated" : {"type": "date"},
        "rating" : {"type": "double"}      
      }      
    }
  }
}
```


La vérification se fait par une simple requête GET sur l'index nouvellement créé. On contrôle ensuite dans la partie settings que l'index possède bien les caractéristiques définies dans le template et dans le mapping.
```shell
GET /hol_devoxxfr_14
```
 

