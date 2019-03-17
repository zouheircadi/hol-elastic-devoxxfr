# Hand On Lab Devoxx France 2019-04
## Recherches full-text
### 3.2 Recherches multichamps - un texte spécifique à chaque champ


###### inject data
```shell
POST /hol_devoxxfr_gstore_320/_doc/_bulk
{ "index": { "_id": 1 }}
{"app_name" : "draw pixel art number", "genres" : "Art & Design;Creativity"}
{ "index": { "_id": 2 }}
{"app_name" : "draw pixel number", "genres" : "Art & Design"}
{ "index": { "_id": 3 }}
{"app_name" : "draw figure", "genres" : "Art & Design"}
```

* Trouver les documents qui contiennent
    * draw dans le champ app_name
    * art dans le champ genres

```shell      
GET  hol_devoxxfr_gstore_320/_search
{
  "query": 
  {
    "bool": 
    {
      "should": 
      [
        {"match": {"app_name": "draw"}},
        {"match": {"genres": "art"}}
      ]  
    }
  }
}
```
