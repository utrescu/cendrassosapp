# No podem entrar si no s'envia un JSON correcte

POST https://{{host}}/api-token-auth/
Content-Type: application/json
"{  patata"

HTTP 400
[Asserts]
header "Content-Type" == "application/json"
jsonpath "$.non_field_errors" exists
jsonpath "$.non_field_errors[0]" == "Dades invàlides. S'espera un diccionari però s'ha rebut str."
