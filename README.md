# Hand On Lab Devoxx France 2019-04
## Gestion des index
### 1.6 Suppression index


###### Supprimer l’index hol_devoxxfr_152
```shell
DELETE /hol_devoxxfr_152
```    

###### Vérifier qu’il l’a bien été en testant son existence 
Une requête REST HEAD sur l'alias doit envoyer un code 
* 404 quand l'alias n'existe pas
* 200 si l'alias existe
```shell
HEAD /hol_devoxxfr_152
```
