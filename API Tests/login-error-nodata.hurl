# No podem entrar si no s'envia un JSON correcte

POST https://djauproves.cendrassos.net/api-token-auth/
Content-Type: application/json

HTTP 400
[Asserts]
header "Content-Type" == "application/json"
# No controla el missatge
