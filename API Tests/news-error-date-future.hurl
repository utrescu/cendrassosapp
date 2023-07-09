
# Comprova que un usuari logejat si no hi ha novetats respon que no

POST https://djauproves.cendrassos.net/api-token-auth/
Content-Type: application/json
{
	"username": "APILd2K",
	"password": "TJmHR79PCxjA"
}

HTTP 200
[Captures]
token: jsonpath "$.token"
[Asserts]
header "Content-Type" == "application/json"



POST https://djauproves.cendrassos.net/api/token/notificacions/news/
Content-Type: application/json
Authorization: JWT {{token}}
{
    "last_sync_date": "2122-11-18 12:00:13"
}


HTTP 200
[Asserts]
jsonpath "$.resultat" == "No"