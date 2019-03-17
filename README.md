# Hand On Lab Devoxx France 2019-04
## Gestion des index
### 1.2 Création template


```shell
PUT /_template/template_hol_dvxfr
{
  "index_patterns": ["hol_devoxxfr*"],
  "settings": 
  {
    "number_of_shards" : 1,
    "number_of_replicas" : 0   
  }
}
```

Le template comprendra 2 parties
* Index patterns : tableau avec l’expression régulière suivante : hol_devoxxfr* 
* Settings
    * Nombre de shards : 1
    * Nombre de replicas : 0

Tous les index dont le nom commencera par hol_devoxxfr auront 1 shard et zéro réplicas

[Allez plus loin](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-templates.html)
