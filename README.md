# Hand On Lab Devoxx France 2019-04
### 3.5 Partial matching
### 3.5.1 Chargement du jeu d’essai

Le jeu d'essai consiste en une liste de pays tronquée à la lettre F. Le chargement peut se faire de deux manières différentes 
* Grâce aux DevTools Kibana.
Copier/Coller dans votre IDE devTools les scripts et exécuter les commandes REST les un après l’autre à partir du fichier ./data/post-data-1-devtools.txt
* shell. 
Exécuter le shell ./data/post-data-1-curl.sh. Il contient les mêmes instructions que le fichier précédent encapsulées dans des commandes Curl
    * Suppression de l’index hol_devoxxfr_pm1
    * Création de l’index hol_devoxxfr_pm1 contenant deux champs de type keyword code et country
    * Ajout des données sur le endpoint bulk
