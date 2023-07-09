
# Comprova que l'alumne pot fer login per obtenir el token
# ------------------------------------------------------------------------------

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


# Comprova que l'alumne pot recuperar dades de família
# ------------------------------------------------------------------------------
GET https://djauproves.cendrassos.net/api/token/alumnes/dades/
Content-Type: application/json
Authorization: JWT {{token}}

HTTP 200
## TODO Comprova?