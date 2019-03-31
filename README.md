# Hand On Lab Devoxx France 2019-04
### 3.6 Spécificités du langage
#### 3.6.1 Les utilisateurs n’en font qu’à leur tête !

###### Faites une requête de type match sur le champ app_name pour la chaîne photos.
```shell
GET hol_devoxxfr_gstore_filter/_search
{
  "query": 
  {
    "match": {
      "app_name": "photos"
    }
  }
}
```

###### Cette requête ne permet de trouver aucun document. Pourquoi (réponse argumentée avec l’outillage mis à disposition par Elasticsearch) ?

```shell
GET hol_devoxxfr_gstore_filter/_analyze
{
  "text": ["photos"],
  "field": "app_name"
}
```

Le terme photos est analysé en photos. Il est donc normal de ne pas le trouver

###### Quel test pourrait-on faire pour trouver un ou des analyzers adéquats sans indexation de données (réponse argumentée avec l’outillage mis à disposition par Elasticsearch)?

```shell
GET hol_devoxxfr_gstore_filter/_analyze
{
  "text": ["photos"],
  "analyzer": "english"
}
```

Ou plus simplement la requête ci-dessous. Le endpoint _analyze peut être invoqué directement et n'exige pas la présence d'un index

```shell
GET _analyze
{
  "text": ["photos"],
  "analyzer": "english"
}
```




#### 3.6.2 Création d’un index personnalisé

Nous allons créer l'index [en deux étapes](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-put-mapping.html)
* création d'un index "vide" (sans mappings mais avec les settings du template)
* création du mapping

Suppression de l'index
```shell
DELETE hol_devoxxfr_lang1
```


Création de l'index
```shell
PUT hol_devoxxfr_lang1
```

Création du mapping
```shell
PUT hol_devoxxfr_lang1/_mapping/_doc
{
  "properties" : 
  {
    "app_name" : 
    {
      "type" : "text",
      "fields" :
      {
        "english" :
        {
          "type" : "text",
          "analyzer" : "english"
        }
      }
    },
    "type" : 
    {
      "type" : "keyword"
    },          
    "genres" : 
    {
      "type" : "text",
      "fields" :
      {
        "english" :
        {
          "type" : "text",
          "analyzer" : "english"
        }
      }
    },
    "category" :
    {
      "type" : "keyword"
    },
    "price" :
    {
      "type" : "double"
    },
    "last_updated" :
    {
      "type" : "date"
    },
    "content_rating" :
    {
      "type" : "text",
      "fields" :
      {
        "keyword" : 
        {
          "type" : "keyword"
        }
      }
    },
    "rating" :
    {
      "type" : "double"
    }     
  }
}
```


#### 3.6.3 Ajout des données
```shell
POST /hol_devoxxfr_lang1/_doc/_bulk
{ "index": { "_id": 1 }}
{"app_name" : "Photo Editor & Candy Camera & Grid & ScrapBook", "type" : "Free", "genres" : "Art & Design", "category" : "ART_AND_DESIGN","price" : 0.0, "last_updated" : "2018-01-06T23:00:00.000Z", "content_rating" : "Everyone","rating" : 4.1}
{ "index": { "_id": 2 }}
{ "app_name" : "Pixel Draw - Number Art Coloring Book", "type" : "Free", "genres" : "Art & Design;Creativity", "category" : "ART_AND_DESIGN",           "price" : 0.0, "last_updated" : "2018-06-19T22:00:00.000Z", "content_rating" : "Everyone", "rating" : 4.3}
{ "index": { "_id": 3 }}
{ "app_name" : "Garden Coloring Book", "type" : "Free", "genres" : "Art & Design", "category" : "ART_AND_DESIGN", "price" : 0.0, "last_updated" : "2017-09-19T22:00:00.000Z", "content_rating" : "Everyone", "rating" : 4.4}
{ "index": { "_id": 4 }}
{ "app_name" : "Tattoo Name On My Photo Editor", "type" : "Free", "genres" : "Art & Design", "category" : "ART_AND_DESIGN",           "price" : 0.0, "last_updated" : "2018-04-01T22:00:00.000Z", "content_rating" : "Teen", "rating" : 4.2}
{ "index": { "_id": 5 }}      
{ "app_name" : "YouTube Kids", "type" : "Free", "genres" : "Entertainment;Music & Video", "category" : "FAMILY",           "price" : 0.0, "last_updated" : "2018-08-02T22:00:00.000Z", "content_rating" : "Everyone", "rating" : 4.5}
{ "index": { "_id": 6 }}      
{ "app_name" : "Candy Bomb", "type" : "Free", "genres" : "Casual;Brain Games", "category" : "FAMILY",           "price" : 0.0, "last_updated" : "2018-07-03T22:00:00.000Z", "content_rating" : "Everyone", "rating" : 4.4}
{ "index": { "_id": 7 }}      
{ "app_name" : "ROBLOX", "type" : "Free", "genres" : "Adventure;Action & Adventure", "category" : "FAMILY",           "price" : 0.0, "last_updated" : "2018-07-30T22:00:00.000Z", "content_rating" : "Everyone 10+", "rating" : 4.5}
{ "index": { "_id": 8 }}      
{ "type" : "Free", "genres" : "Casual;Brain Games", "category" : "FAMILY",           "price" : 0.0, "last_updated" : "2018-07-22T22:00:00.000Z", "content_rating" : "Everyone", "rating" : 4.4}
{ "index": { "_id": 9 }}      
{ "app_name" : "Bowmasters", "type" : "Free", "genres" : "Action", "category" : "GAME",           "price" : 0.0, "last_updated" : "2018-07-22T22:00:00.000Z", "content_rating" : "Teen", "rating" : 4.7}
{ "index": { "_id": 10 }}      
{ "app_name" : "Magic Tiles 3", "@timestamp" : "2019-03-02T07:03:20.040Z", "type" : "Free", "genres" : "Music", "category" : "GAME", "price" : 0.0, "last_updated" : "2018-08-02T22:00:00.000Z", "content_rating" : "Everyone", "rating" : 4.5}
{ "index": { "_id": 11 }}      
{ "app_name" : "Block Puzzle Classic Legend !", "@timestamp" : "2019-03-02T07:03:20.040Z", "type" : "Free", "genres" : "Puzzle", "category" : "GAME",           "price" : 0.0, "last_updated" : "2018-04-12T22:00:00.000Z", "content_rating" : "Everyone", "rating" : 4.2}
{ "index": { "_id": 12 }}      
{ "app_name" : "Marble Woka Woka 2018 - Bubble Shooter Match 3", "type" : "Free", "genres" : "Puzzle", "category" : "GAME",           "price" : 0.0, "last_updated" : "2018-08-02T22:00:00.000Z", "content_rating" : "Everyone", "rating" : 4.6}
{ "index": { "_id": 13 }}      
{ "app_name" : "QR Code Reader", "type" : "Free", "genres" : "Tools", "category" : "TOOLS",           "price" : 0.0, "last_updated" : "2016-03-15T23:00:00.000Z", "content_rating" : "Everyone", "rating" : 4.0}
{ "index": { "_id": 14 }}      
{ "app_name" : "SHAREit - Transfer & Share", "type" : "Free", "genres" : "Tools", "category" : "TOOLS",           "price" : 0.0, "last_updated" : "2018-07-29T22:00:00.000Z", "content_rating" : "Everyone", "rating" : 4.6}
{ "index": { "_id": 15 }}      
{ "app_name" : "Diabetes:M", "type" : "Free", "genres" : "Medical", "category" : "MEDICAL", "price" : 0.0, "last_updated" : "2018-07-31T22:00:00.000Z", "content_rating" : "Everyone", "rating" : 4.6}      
```


#### 3.6.4 Requêtes


* Approche naïve
```shell
GET hol_devoxxfr_lang1/_search
{
  "query": 
  {
    "multi_match": {
      "query": "photos",
      "fields": ["app_name"]
    }
  }
}
```


* Je connais mon mapping et je sais ajouter des champs imbriqués dans la requête multifields pour tenir compte de la langue du texte pour augmenter le recall
```shell
GET hol_devoxxfr_lang1/_search
{
  "query": 
  {
    "multi_match": {
      "query": "photos",
      "fields": ["app_name","app_name.english"]
    }
  }
}
```


* Je joue sur la pondération. Dans ce cas d'utilisation, si on considère qu'on veut retourner aux utilisateurs en priorité les documents qui contiennent les chaïnes de caractère les plus proches de leurs saisies, on peut 
    * augmenter la pondération du champ app_name qui utilise le standard analyzer (tokens stockés sans modification).
    * ajouter dans les champs recherchés le champ qui fait l'objet d'une analyse spécifique à la langue sans nécessairement toucher à la pondération   

On constate ainsi que l'augmentation de la pondération du champ app_name ne change pas le score car le terme photos n'est pas trouvé. C'est le terme photo qui est trouvé dans le champ app_name.english. Cette démarche permet d'augmenter simultanément 
* la précision : augmentation du score des résultats pertinents qui apparaitront ainsi en premier dans la recherche
* le recall : recherche dans un ou des champs avec des indexations qui reduisent l'inflexion et augmentent ainsi la probabilité de trouver des termes proches

Pour conclure, il faut bien garder à l'esprit que la query de type pierre philosphale n'existe pas. Une requête et le tuning correspondant ne sont que l'expression d'un cas d'utilisation. 

```shell
GET hol_devoxxfr_lang1/_search
{
  "query": 
  {
    "multi_match": {
      "query": "photos",
      "fields": ["app_name^4","app_name.english"]
    }
  }
}
```
