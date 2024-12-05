
# Comprova que un usuari logejat pot demanar les notificacions

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



GET https://{{host}}/api/token/sortides/455/
Content-Type: application/json
Authorization: Bearer {{token}}

HTTP 200
[Asserts]
jsonpath "$.[0].id" exists
jsonpath "$.[0].darrera_sincronitzacio" exists

