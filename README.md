# Hand On Lab Devoxx France 2019-04
## Recherches full-text
### 3.3 Recherches multichamps - un texte commun à tous les champs


##### 3.1.1

```shell      
GET  hol_devoxxfr_gstore_320/_search
{
  "query": 
  {
    "bool": 
    {
      "should": 
      [
        {"match": {"app_name": "draw art"}},
        {"match": {"genres": "draw art"}}
      ]  
    }
  }
}
```


##### 3.1.1 Effets de bord du mode précédent

```shell      

```


###### Recherches de type Dismax

```shell      

```


###### Recherches de type Dismax  - effet de bord

```shell      

```


###### Recherches de type Dismax  avec tiebreaker

```shell      

```


###### Comprendre le score du mode Dismax

```shell      

```


###### Queries de type Multimatch

```shell      

```
