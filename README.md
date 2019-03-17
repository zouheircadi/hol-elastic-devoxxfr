# Hand On Lab Devoxx France 2019-04
## Recherches full-text
### 3.1 Recherches sur un champ unique


###### Match query
Quels sont les documents qui contiennent le terme draw dans le champ app_name ?
```shell
GET hol_devoxxfr_gstore_310/_search
{
  "query": 
  {
    "match": {
      "app_name": "draw"
    }
  }
}
      
```    


###### Comprendre le score - recherche d’un terme unique
Comment se décompose le score du premier document trouvé pour la requête précédente ?

```shell
GET hol_devoxxfr_gstore_310/_search?explain=true
{
  "query": 
  {
    "match": {
      "app_name": "draw"
    }
  }
}      
```   

Décomposition du score du premier document remonté qui a le score le plus élevé
* 0.15461528 = 
    * 0,13353139 => idf log(1 + (docCount - docFreq + 0.5) / (docFreq + 0.5))
    * (*)
    *  1,1578947 => tf (freq * (k1 + 1)) / (freq + k1 * (1 - b + b * fieldLength / avgFieldLength))


###### OR
Quels sont les documents qui contiennent les termes draw ou art dans le champ app_name ?

```shell
GET hol_devoxxfr_gstore_310/_search
{
  "query": 
  {
    "match": {
      "app_name": "draw art"
    }
  }
}      
```    

###### Comprendre le score - recherche de plusieurs termes
Comment se décompose le score du premier document trouvé pour la requête OR ?

```shell
GET hol_devoxxfr_gstore_310/_search?explain=true
{
  "query": 
  {
    "match": {
      "app_name": "draw art"
    }
  }
}
      
```   

Décomposition du score du premier document remonté qui a le score le plus élevé
* 0.9806374 = 
    * score de draw
    * 0.11750762 => (0,13353139 * 0,88)
    * (+)
    * score de art
    * 0.86312973 => (0,98082924 * 0,88)


###### AND
Quels sont les documents qui contiennent les termes draw et art dans le champ app_name ?

```shell
GET hol_devoxxfr_gstore_310/_search
{
  "query": 
  {
    "match": 
    {
      "app_name" :
      {
        "query": "draw art",
        "operator": "and"
      }
    }
  }
}      
```    
