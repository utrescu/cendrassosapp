# Comprova l'error si no enviem el token

GET https://djauproves.cendrassos.net/api/token/notificacions/mes/11/
Content-Type: application/json

HTTP 401
[Asserts]
jsonpath "$.detail" exists
jsonpath "$.detail" == "Credencials d'autenticació no disponibles."
