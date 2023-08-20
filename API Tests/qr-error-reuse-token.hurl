# Comprova l'error que es rep en reutilitzar el token
# ------------------------------------------------------------------------

POST https://{{host}}/api/token/capture_token_api/
Content-Type: application/json
{
	"key": "bc25a93a-9b24-4c1c-9deb-01c8ded47f22",
	"born_date": "2004-05-26"
}

HTTP 400
[Asserts]
header "Content-Type" == "application/json"
jsonpath "$.error" exists
jsonpath "$.error[0]" == "ups! Aquest QR no serveix. Potser ja l'has utilitzat abans?"


