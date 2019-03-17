# Hand On Lab Devoxx France 2019-04
## Gestion des index
### 1.3 Creation d’un index sur la base d’un template

Créer un index par injection de données avec le POST ci-dessous. L’index créé devrait logiquement avoir les caractéristiques définies dans le template
      
```shell
POST /hol_devoxxfr_13/_doc/_bulk
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

**Vérifier que l’index nouvellement créé possède bien les caractéristiques définis dans le template (un seul shard et zéro replica)**

Pour créer un index dont la structure obéit à un template, il suffit de respecter l’expression régulière présente dans l’attribut index_pattern utilisée lors de sa création.
La vérification se fait par une simple requête GET sur l'index nouvellement créé. On contrôle ensuite dans la partie settings que l'index possède bien les caractéristiques définies dans le template.
```shell
GET /hol_devoxxfr_13
```
 


Résultat de sortie
```json
{
  "hol_devoxxfr_13" : {
    "aliases" : { },
    "mappings" : {
      "_doc" : {
        "properties" : {
          "app_name" : {
            "type" : "text",
            "fields" : {
              "keyword" : {
                "type" : "keyword",
                "ignore_above" : 256
              }
            }
          },
          "category" : {
            "type" : "text",
            "fields" : {
              "keyword" : {
                "type" : "keyword",
                "ignore_above" : 256
              }
            }
          },
          "last_updated" : {
            "type" : "date"
          },
          "rating" : {
            "type" : "float"
          }
        }
      }
    },
    "settings" : {
      "index" : {
        "creation_date" : "1552152736309",
        "number_of_shards" : "1",
        "number_of_replicas" : "0",
        "uuid" : "0y7MR1CVQnOs3NgQiZFGUA",
        "version" : {
          "created" : "6060099"
        },
        "provided_name" : "hol_devoxxfr_13"
      }
    }
  }
}
```