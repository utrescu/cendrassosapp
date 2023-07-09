
# Comprova que un usuari logejat pot demanar les notificacions

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



GET https://djauproves.cendrassos.net/api/token/notificacions/mes/11/
Content-Type: application/json
Authorization: JWT {{token}}

HTTP 200
[Asserts]
jsonpath "$.[0].id" exists
jsonpath "$.[0].darrera_sincronitzacio" exists

