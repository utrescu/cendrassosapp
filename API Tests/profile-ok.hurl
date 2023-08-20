
# Comprova que l'alumne pot fer login per obtenir el token
# ------------------------------------------------------------------------------

POST https://{{host}}/api-token-auth/
Content-Type: application/json
{
	"username": "{{username}}",
	"password": "{{password}}"
}

HTTP 200
[Captures]
token: jsonpath "$.access"
[Asserts]
header "Content-Type" == "application/json"


# Comprova que l'alumne pot recuperar dades de família
# ------------------------------------------------------------------------------
GET https://{{host}}/api/token/alumnes/dades/
Content-Type: application/json
Authorization: Bearer {{token}}

HTTP 200
## TODO Comprova?