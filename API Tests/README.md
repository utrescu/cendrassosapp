# Tests de l'API del Djau

Es tests estan fets amb [Hurl](https://github.com/Orange-OpenSource/hurl).

La instal·lació no hauria de ser un problema ja que només cal obtenir el binari de "Releases" (o instal·lar-lo amb **cargo** de Rust)

## Executar tots els tests

> El test d'obtenir credencials està a part perquè només es pot executar una sola vegada.

Per executar tots els tests:

```bash
hurl --test --error-format=long *.hurl
```

Va mostrant l'execució de cada un dels tests i en acabar dóna una estadística del resultat:

```log
...
profile-error-notoken.hurl: Success (1 request(s) in 126 ms)
profile-ok.hurl: Running [13/17]
profile-ok.hurl: Success (2 request(s) in 341 ms)
qr-error-no-borndate.hurl: Running [14/17]
qr-error-no-borndate.hurl: Success (1 request(s) in 144 ms)
qr-error-no-data.hurl: Running [15/17]
qr-error-no-data.hurl: Success (1 request(s) in 142 ms)
qr-error-no-key.hurl: Running [16/17]
qr-error-no-key.hurl: Success (1 request(s) in 147 ms)
qr-error-reuse-token.hurl: Running [17/17]
qr-error-reuse-token.hurl: Success (1 request(s) in 150 ms)
--------------------------------------------------------------------------------
Executed files:  17
Succeeded files: 14 (82.4%)
Failed files:    3 (17.6%)
Duration:        3479 ms
```

En l'execució es poden veure a què són deguts els errors ja que al afegir `--error-message=long" mostra les capçaleres i el contingut de la resposta rebuda:

```log
news-error-date-future.hurl: Running [4/17]
HTTP/1.1 200
Date: Sun, 09 Jul 2023 15:17:36 GMT
Server: Apache/2.4.41 (Ubuntu)
Content-Length: 18
Vary: Accept
Allow: POST, OPTIONS
X-Frame-Options: DENY
X-Content-Type-Options: nosniff
Referrer-Policy: same-origin
Content-Type: application/json

{"resultat":"Sí"}

error: Assert failure
  --> news-error-date-future.hurl:29:0
   |
29 | jsonpath "$.resultat" == "No"
   |   actual:   string <Sí>
   |   expected: string <No>
   |

news-error-date-future.hurl: Failure (2 request(s) in 304 ms)
```

Hurl es pot executar de moltes altres formes. La documentació és bastant explícita.
