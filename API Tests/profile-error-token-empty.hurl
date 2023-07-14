# Comprova l'error si no enviem token
# ------------------------------------------------------------------------------
GET https://djauproves.cendrassos.net/api/token/alumnes/dades/
Content-Type: application/json
Authorization: JWT

HTTP 401
[Asserts]
jsonpath "$.detail" exists
jsonpath "$.detail" == "Invalid Authorization header. No credentials provided."
