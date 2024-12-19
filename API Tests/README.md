# Tests de l'API del Djau

Es tests estan fets amb [Hurl](https://github.com/Orange-OpenSource/hurl).

La instal·lació no hauria de ser un problema ja que només cal obtenir el binari de "Releases" (o instal·lar-lo amb **cargo** de Rust)

## Executar tots els tests

> El test d'obtenir credencials està a part perquè només es pot executar una sola vegada.

Abans d'executar els tests cal tenir jocs de proves correctes:

- Adreça del host on fer les proves
- un usuari i una contrasenya verificats
- Identificadors per una sortida que s'ha de pagar
- Id d'una sortida que no s'ha de pagar
- Id que no és una sortida (suposo que el que ja hi ha mai existirà)


S'edita el fitxer `vars.env` i s'hi defineix el host on està instal·lat el programa, l'usuari amb el que es faran les proves i la seva contrasenya:

```ìni
host=djauproves.cendrassos.net
username=API1RRE
password=oJFbfMG5T95S
sortidaOk=437
sortidaOkNoPagament=189
sortidaInexistent=99999
```

Per executar tots els tests:

```bash
hurl --test --variables-file vars.env --error-format=long */*.hurl
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

## Executar les proves d'un sol domini

Les proves estan organitzades en directoris que reflecteixen els dominis de les preguntes a l'API. Per tant per executar les proves només cal especicicar el directori. Per exemple per executar totes les proves de la part de "sortides":

```bash
$ hurl --test --variables-file vars.env --error-format=long sortides/*
sortides/sortides-detall-badtoken.hurl: Running [1/7]
sortides/sortides-detall-badtoken.hurl: Success (1 request(s) in 26 ms)
sortides/sortides-detall-no-existeix.hurl: Running [2/7]
sortides/sortides-detall-no-existeix.hurl: Success (2 request(s) in 396 ms)
sortides/sortides-detall-no-pagament-ok.hurl: Running [3/7]
sortides/sortides-detall-no-pagament-ok.hurl: Success (2 request(s) in 364 ms)
sortides/sortides-detall-ok.hurl: Running [4/7]
sortides/sortides-detall-ok.hurl: Success (2 request(s) in 367 ms)
sortides/sortides-llista-error-badtoken.hurl: Running [5/7]
sortides/sortides-llista-error-badtoken.hurl: Success (1 request(s) in 22 ms)
sortides/sortides-llista-notoken.hurl: Running [6/7]
sortides/sortides-llista-notoken.hurl: Success (1 request(s) in 21 ms)
sortides/sortides-llista-ok.hurl: Running [7/7]
sortides/sortides-llista-ok.hurl: Success (2 request(s) in 406 ms)
--------------------------------------------------------------------------------
Executed files:  7
Succeeded files: 7 (100.0%)
Failed files:    0 (0.0%)
Duration:        1617 ms
```

## Executar un sol test

Per executar un sol test només només cal referenciar-lo directament:

```bash
$ hurl --test --variables-file vars.env --error-format=long profile/profile-ok.hurl
profile/profile-ok.hurl: Success (2 request(s) in 7830 ms)
--------------------------------------------------------------------------------
Executed files:    1
Executed requests: 2 (0.3/s)
Succeeded files:   1 (100.0%)
Failed files:      0 (0.0%)
Duration:          7844 ms
```

## Altres

Hurl es pot executar de moltes altres formes. La documentació és bastant explícita.
