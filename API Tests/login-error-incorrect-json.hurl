# No podem entrar si no s'envia un JSON correcte

POST https://djauproves.cendrassos.net/api-token-auth/
Content-Type: application/json
"{  patata"

HTTP 400
[Asserts]
header "Content-Type" == "application/json"
jsonpath "$.error" exists
jsonpath "$.error[0]" == "Dades invàlides. S'espera un diccionari però s'ha rebut str."
