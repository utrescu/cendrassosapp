# Comprova l'error si no enviem token
# ------------------------------------------------------------------------------
GET https://{{host}}/api/token/alumnes/dades/
Content-Type: application/json
Authorization: JWT

HTTP 401
[Asserts]
jsonpath "$.detail" exists
jsonpath "$.detail" == "Credencials d'autenticació no disponibles."
