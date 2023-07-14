
# Comprova que pot demanar mesos incorrectes i no dóna error

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


GET https://djauproves.cendrassos.net/api/token/notificacions/mes/25/
Content-Type: application/json
Authorization: JWT {{token}}

HTTP 400
[Asserts]
jsonpath "$.error" exists
jsonpath "$.error[0]" == "Mes inexistent"

