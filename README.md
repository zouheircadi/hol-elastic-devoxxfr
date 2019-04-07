# Hand On Lab Devoxx France 2019-04
# 2. Recherches
### 2.4 Partial matching
#### 2.4.2 Partial matching sans modification de l’indexation
##### 2.4.2.1 Prefix query  

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



##### 2.4.2.2 RegExp query

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
      "explanation" : "country:/.*Repu.*/"
    }
  ]
}
```


#### Note. 
Le typage du champ country est keyword. Il faut donc respecter la casse pour faire les requêtes. Si les champs étaient de type text, il aurait fallu veiller à faire la requête avec la même casse que la donnée indexée. Il faut bien garder à l'esprit les caractéristiques ci-dessous lors de l'utilisation de ce type de requête
* Prend en compte le terme exact. Il n'y a pas d'analyse préalable. Il faut utiliser ces requêtes sur des champs non analysés
* Ne calcule pas de score
* Requêtes inefficace à proscrire sur des corpus volumineux en tenant compte de la cardinalité du champ


##### 2.4.2.3 match_phrase_prefix 

###### En vous aidant de la documentation en ligne pour la syntaxe, trouver les documents dont le champ country commence par cong.
```shell
GET /hol_devoxxfr_pm1/_search
{
  "query": 
  {
    "match_phrase_prefix": {
      "country": "cong"
    }
  }
}
``` 

###### Si vous avez chargé le jeu d’essais avec les scripts qui vous ont été procurés, la recherche devrait être infructueuse. Pourquoi ?
```shell
GET /hol_devoxxfr_pm1/_validate/query?explain
{
  "query": 
  {
    "match_phrase_prefix": {
      "country": "cong"
    }
  }
}
```

La chaine cong devrait être jokérisée. Ca n'est pas le cas. Pensez aussi au fait que les champs sont de type keyword

###### Créer un autre index hol_devoxxfr_pm2 avec le bon mapping et recharger les données. 

Le mapping correct vous est fourni dans le fichier shell ./data/post-data-2-curl.sh. Le mapping du champ country est maintenant de type text

Si vous n’avez pas la possibilité d’exécuter un script shell sur votre poste de travail, sachez qu’un copier/coller d’une instruction Curl vers les devTools Kibana transforme automatiquement la commande Curl dans la syntaxe du devTool.


###### validate de la query sur le nouvel index
```shell
GET /hol_devoxxfr_pm2/_validate/query?explain
{
  "query": 
  {
    "match_phrase_prefix": {
      "country": "cong"
    }
  }
}
```
* explain sur le champ donne maintenant un résultat jokérisé


###### Refaites la requête sur l’index hol_devoxxfr_pm2
```shell
GET /hol_devoxxfr_pm2/_search
{
  "query": 
  {
    "match_phrase_prefix": {
      "country": "cong"
    }
  }
}
```

