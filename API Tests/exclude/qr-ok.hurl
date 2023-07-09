# Comprova l'error que es rep en no enviar res
# Per la forma de funcionar no es pot repetir

POST https://djauproves.cendrassos.net/api/token/capture_token_api/
Content-Type: application/json
{
	"key": "113d735b-efe1-4629-97a0-233f30ae20dc",
	"born_date": "2004-05-13"
}

HTTP 200
[Captures]
my_username: jsonpath "$.username"
my_password: jsonpath "$.password"
[Asserts]
header "Content-Type" == "application/json"
jsonpath "$.error[0]" == "ups! Aquest token no serveix"

# Fer login
# ------------------------------------------------------------------------

POST https://djauproves.cendrassos.net/api-token-auth/
Content-Type: application/json
{
    "username":"{{my_username}}",
	"password": "{{my_password}}"
}

HTTP 400
[Asserts]
header "Content-Type" == "application/json"
jsonpath "$.error[0]" == "No es possible loguejar-se amb les credencials introduïdes."
