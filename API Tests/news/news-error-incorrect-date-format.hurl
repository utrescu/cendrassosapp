# Comprova que un usuari logejat rep error si envia la data en un format incorrecte

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


# ------------ CAS 1 ----------------------------


POST https://{{host}}/api/token/notificacions/news/
Content-Type: application/json
Authorization: Bearer {{token}}
{
    "last_sync_date": "23/4/2021"
}


HTTP 400
[Asserts]
jsonpath "$.error" exists
jsonpath "$.error[0]" == "ups! petició amb errors"


# ------------ CAS 2 ----------------------------

POST https://{{host}}/api/token/notificacions/news/
Content-Type: application/json
Authorization: Bearer {{token}}
{
    "last_sync_date": "patata"
}


HTTP 400
[Asserts]
jsonpath "$.error" exists
jsonpath "$.error[0]" == "ups! petició amb errors"