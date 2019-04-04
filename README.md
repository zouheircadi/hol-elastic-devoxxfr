# Hand On Lab Devoxx France 2019-04
## Gestion des index
### 1.4 Création Index avec mapping personnalisé

Créer un index avec les caractéristiques suivantes
* Nom : hol_devoxxfr_14
* Dont le mapping est
    * Type : _doc
        * Champs
            * app_name : chaine de caractère analysée
            * category : chaine de caractère non analysée
            * last_updated : date
            * rating : double

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

Indexer les données avec la requête REST ci-dessous
```shell
POST /hol_devoxxfr_14/_doc/_bulk
{ "index": { "_id": 1 }}
{"app_name" : "Photo Editor", "category" : "ART-AND-DESIGN", "last_updated" : "2018-01-06","rating" : 4.1}
{ "index": { "_id": 2 }}
{ "app_name" : "YouTube Kids", "category" : "FAMILY", "last_updated" : "2018-08-02", "rating" : 4.5}
{ "index": { "_id": 3 }}      
{ "app_name" : "Block Puzzle Classic Legend !","category" : "GAME", "last_updated" : "2018-07-22", "rating" : 4.7}
{ "index": { "_id": 4 }}      
{ "app_name" : "Marble Woka Woka 2018 - Bubble Shooter Match 3", "category" : "GAME", "last_updated" : "2018-08-02","rating" : 4.6}
{ "index": { "_id": 5 }}      
{ "app_name" : "QR Code Reader", "category" : "TOOLS", "last_updated" : "2016-03-15", "rating" : 4.0}
{ "index": { "_id": 6 }}      
{ "app_name" : "Diabetes:M", "category" : "MEDICAL", "last_updated" : "2018-07-31", "rating" : 4.6}      
```

Vérifier que votre index 
* contient bien un seul shard avec zéro réplica
* que le mapping est différent de celui inféré par défaut


La vérification se fait par une simple requête GET sur l'index nouvellement créé. On contrôle ensuite dans la partie settings que l'index possède bien les caractéristiques définies dans le template et dans le mapping.
```shell
GET /hol_devoxxfr_14
```

Résultat de sortie du GET
```json
{
  "hol_devoxxfr_14" : {
    "aliases" : { },
    "mappings" : {
      "_doc" : {
        "properties" : {
          "app_name" : {
            "type" : "text"
          },
          "category" : {
            "type" : "keyword"
          },
          "last_updated" : {
            "type" : "date"
          },
          "rating" : {
            "type" : "double"
          }
        }
      }
    },
    "settings" : {
      "index" : {
        "creation_date" : "1552152453624",
        "number_of_shards" : "1",
        "number_of_replicas" : "0",
        "uuid" : "9tX0PEOjQpGXXGEbjPSroQ",
        "version" : {
          "created" : "6060099"
        },
        "provided_name" : "hol_devoxxfr_14"
      }
    }
  }
}
```
 

