# Hand On Lab Devoxx France 2019-04
## Recherches full-text
### 3.2 Recherches multichamps - un texte spécifique à chaque champ


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
