curl -XPOST "http://localhost:9200/hol_devoxxfr_filter/_doc/_bulk" -H 'Content-Type: application/json' -d'
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
'
