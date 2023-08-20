# Comprova que dona error si un usuari logejat no envia la last_sync_date

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



POST https://{{host}}/api/token/notificacions/news/
Content-Type: application/json
Authorization: Bearer {{token}}


HTTP 400
[Asserts]
jsonpath "$.detail" exists
jsonpath "$.detail" == "JSON parse error - Expecting value: line 1 column 1 (char 0)"