# No podem entrar si no hi ha dades
# -----------------------------------------------------------------------------
POST https://{{host}}/api-token-auth/
Content-Type: application/json
{
}

HTTP 400
[Asserts]
header "Content-Type" == "application/json"
# No capturar el missatge
