
# Comprova que no es veuen les sortiddes si no accepta el token

GET https://{{host}}/api/token/sortides/{{sortidaOk}}/
Content-Type: application/json
Authorization: Bearer "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMjQyLCJ1c2VybmFtZSI6IkFQSUxkMksiLCJleHAiOjE2ODg3NTU3NDYsImVtYWlsIjoiIiwib3JpZ19pYX22222ODg3Mzc3NDZ9.rAIVJTrFATWJ7t7rwz4rb-_DN3fu3P22YGBW53f3558"
{
    "last_sync_date": "2122-11-18 12:00:13"
}


HTTP 401
[Asserts]
jsonpath "$.detail" exists
jsonpath "$.detail" == "Given token not valid for any token type"






