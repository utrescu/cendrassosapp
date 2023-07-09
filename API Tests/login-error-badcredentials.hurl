
# No podem entrar si l'usuari o la contasenya no són correctes

POST https://djauproves.cendrassos.net/api-token-auth/
Content-Type: application/json
{
	"username": "APILd2K",
	"password": "TJmHR79PC"
}

HTTP 400
[Asserts]
header "Content-Type" == "application/json"
# jsonpath "$.non_field_errors" exists
# jsonpath "$.non_field_errors[0]" == "No es possible loguejar-se amb les credencials introduïdes."
jsonpath "$.error" exists
jsonpath "$.error[0]" == "No es possible loguejar-se amb les credencials introduïdes."
