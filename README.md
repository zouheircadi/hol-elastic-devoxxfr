# Hand On Lab Devoxx France 2019-04
### 3.5 Partial matching
### 3.5.3 Sans modification de l’indexation : match_phrase_prefix

Le mapping correct vous est fourni dans le fichier shell ./data/post-data-2-curl.sh

Si vous n’avez pas la possibilité d’exécuter un script shell sur votre poste de travail, sachez qu’un copier/coller d’une instruction Curl vers les devTools Kibana transforme automatiquement la commande Curl dans la syntaxe du devTool.


###### match phrase prefix
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

###### validate de la query
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