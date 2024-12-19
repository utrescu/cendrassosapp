# Comprova l'error que es rep en no enviar la key

POST https://{{host}}/api/token/capture_token_api/
Content-Type: application/json
{
	"key": "",
	"born_date": "2004-05-26"
}

HTTP 400
[Asserts]
header "Content-Type" == "application/json"
jsonpath "$.error" exists
jsonpath "$.error[0]" == "ups! Aquest token no serveix"


