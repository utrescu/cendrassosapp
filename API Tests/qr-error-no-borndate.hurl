# Comprova l'error que es rep en no enviar data de naixement

POST https://djauproves.cendrassos.net/api/token/capture_token_api/
Content-Type: application/json
{
	"key": "aaa",
	"born_date": ""
}

HTTP 400
[Asserts]
header "Content-Type" == "application/json"
jsonpath "$.error" exists
jsonpath "$.error[0]" == "ups! Aquest token no serveix"



