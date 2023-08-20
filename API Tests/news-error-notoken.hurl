# Comprova l'error si no enviem el token
# ------------------------------------------------------------------------------
POST https://{{host}}/api/token/notificacions/news/
Content-Type: application/json
{
    "last_sync_date": "2122-11-18 12:00:13"
}

HTTP 401
[Asserts]
jsonpath "$.detail" exists
jsonpath "$.detail" == "Credencials d'autenticació no disponibles."
