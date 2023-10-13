# Changelog

## Unreleased

## [v1.0.0](https://github.com-utrescu/utrescu/cendrassosapp/compare/v0.9.0...v1.0.0) (2023-10-12)

### Added

- test(api): Afegeix tests de l'API amb hurl.
- feat!(login): Afegeix login amb codi QR.

### Changed

- refactor!: S'adapta als canvis en l'API
- build: Actualitza paquets de Flutter.
- feat(login): Sempre fa login per comprovar novetats.
- refactor: Extreu les cadenes en constants.
- refactor: Defineix el navegador global.
- refactor: Treure parts no usades.
- refactor(ui): Refer aspecte de les pantalles.

### Fixed

- fix(android): Adapta les notificacions a la nova versió.
- fix: Arregla l'estat en vacances.
- fix: Arregla l'accés sense token a l'API.
- fix: Soluciona problemes amb comunicació amb l'api amb UTF8.
- fix(ui): Arregla textos erronis.
- fix: Arregla error de compilació Linux.

## v0.9.0 (2022-03-17)

### Added

- Afegeix i modifica la pàgina de perfil
- Afegeix Splash screen.
- Afegeix l'opció d'esborrar alumnes
- Afegeix el Background service.
- Afegeix la pantalla de llista d'alumnes

### Changed

- refactor!: S'adapta a les diferències en l'API desemvpñiàda
- Reorganitza components de pantalla.
- Carrega app des de la notificació.
- Modifica configuració afegint l'adreça pública.
- El calendari pot col·lapsar-se.
- Redissenya pantalles, icones i colors
- Separa la configuració del tema.
- Defineix la mida de finestra en Linux

### Fixed

- Arregla botó retry.
- Canvia les notificacions a quadres en comptes de punts.
- Adapta el codi de login i permet autologin
- Arregla la compilació d'Android.
- Soluciona el problema amb selectedday i treu mides de font.
- Incrementa el control dels errors de xarxa.

### Security

- Baixa la versió de preferences android per bug.
- BUGFIX formulari login i adaptar REST.
