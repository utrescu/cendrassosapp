# Comprova que dona error si un usuari logejat no envia la last_sync_date

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


HTTP 400
[Asserts]
jsonpath "$.detail" exists
jsonpath "$.detail" == "JSON parse error - Expecting value: line 1 column 1 (char 0)"