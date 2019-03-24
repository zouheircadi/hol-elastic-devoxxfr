# Hand On Lab Devoxx France 2019-04
### 3.5 Partial matching
#### 3.5.1 Prefix query et Regexp query
##### 3.5.1.1 Prefix query  

```shell
GET /hol_devoxxfr_pm1/_search
{
  "query" :
  {
    "prefix": {
      "country": {
        "value": "Ba"
      }
    }
  }
}
```

###### validate pour voir la chaine utilisée dans la requête

```shell
GET /hol_devoxxfr_pm1/_validate/query?explain
{
  "query" :
  {
    "prefix": {
      "country": {
        "value": "Ba"
      }
    }
  }
}
```

Résultat
```json
{
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "failed" : 0
  },
  "valid" : true,
  "explanations" : [
    {
      "index" : "hol_devoxxfr_pm1",
      "valid" : true,
      "explanation" : "country:Ba*"
    }
  ]
}
```
Le prefixe recherché est la chaine Ba. La casse de la chaine n'est pas modifié.



##### 3.5.1.2 RegExp query

```shell
GET /hol_devoxxfr_pm1/_search
{
  "query" :
  {
    "regexp": {
      "country": {
        "value": ".*Repu.*"
      }
    }
  }
}
```


###### Validate pour voir la chaine utilisée dans la requête

```shell
GET /hol_devoxxfr_pm1/_validate/query?explain
{
  "query" :
  {
    "regexp": {
      "country": {
        "value": ".*Repu.*"
      }
    }
  }
}
```


#### Note. 
Le typage du champ country est keyword. Il faut donc respecter la casse pour faire les requêtes. Si les champs étaient de type text, il aurait fallu veiller à faire la requête avec la même casse que la donnée indexée. Il faut bien garder en tête les caractéristiques ci-dessous lors de l'utilisation de ce type de requête
* Prend en compte le terme exact. Il n'y a pas d'analyse préalable. Il faut utiliser ces requêtes sur des champs non analysés
* Ne calcule pas de score
* Requêtes inéfficace à proscrire sur des corpus volumineux en tenant compte de la cardinalité du champ

