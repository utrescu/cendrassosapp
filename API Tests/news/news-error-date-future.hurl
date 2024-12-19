
# Comprova que un usuari logejat si no hi ha novetats respon que no

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
{
    "last_sync_date": "2122-11-18 12:00:13"
}


HTTP 200
[Asserts]
jsonpath "$.resultat" == "No"