import 'dart:ui';

const String appName = "Cendrassos";

// Dades del centre
const String nomInstitut = "Institut Cendrassos";
// URL del Djau de proves
const String baseUrl = "https://djauproves.cendrassos.net";
// URL del Djau en producció
// const String baseUrl = "https://djau.cendrassos.net";

// Mesos d'inici i final del curs
const int mesIniciCurs = 9;
const int mesFinalCurs = 6;
const int intervalNotificacions = 15; // Cada quants minuts comprova notificacions

// Llista dels tipus de notificacions i els colors amb el que es veuran
// Comprovar que el text és el que arriba en la notificació. Si en calen
// més, s'afegeixen.
Map<String, Color> notificacionsColor = {
  "Falta": const Color(0xFF00BCD4),
  "Retard": const Color.fromARGB(255, 197, 196, 123),
  "Justificada": const Color(0xFF4CAF50),
  "Incidència": const Color(0xFFFF9800),
  "Expulsió": const Color(0xFFF44336),
  "Observació": const Color.fromARGB(255, 197, 116, 190),
};

// Textos del programa
// -------------------------------------------------------------------

// Constants del calendari
const String calendariCollapsa = "Col·lapsa";
const String calendarMostrames = "Veure el mes";

// Textos dels missatges que es mostren per pantalla

const String etiquetaProfessor = "Professor";
const String etiquetaHora = "";
const String etiquetaDia = "Dia:";
const String etiquetaDataNaixement = 'Entreu la data de naixement';
const String etiquetaEnviarQR = 'Enviar petició';

const String missatgeCarregantDades = "Carregant dades";
const String missatgeTornaAProvar = "Torna-ho a provar";
const String missatgeTornaALogin = 'Entrar credencials de nou';
const String missatgeOk = "D'acord";
const String missatgeEliminant = "Eliminant";

const String defaultErrorMessage = "ERROR";
const String undefinedError = "Hi ha hagut un error indeterminat";
const String errorCarregant =
    "ERROR carregant les dades. Torna-ho a provar més tard";
const String errorQR = "El codi QR és incorrecte";

// Sortides
const String carregantSortides = "Recuperant sortides";

// Tipus d'errors de l'API
const String communicationExceptionMessage = "Error durant la comunicació: ";
const String invalidPetitionExceptionMessage = "Petició invàlida: ";
const String notAuthorizedExceptionMessage = "No Autoritzat: ";
const String invalidInputExceptionMessage = "Entrada incorrecta: ";

// URLs d'accés a l'API
// Normalment no s'hauria de canviar res si no es canvia l'API
// -------------------------------------------------------------------

// La URL ha d'acabar amb una barra
const String endBaseUrl = "/";

// Es fa login amb codis QR?
const bool loginWithQR = true;

// API QR Login
const String qrToken = "/api/token/capture_token_api";
// API Login
const String pathLogin = "/api-token-auth";
const String tokenRefresh = "/api-token-refresh";

const String pathNotificacions = "/api/token/notificacions/mes";
const String pathNews = "/api/token/notificacions/news";
const String pathProfile = "/api/token/alumnes/dades";
const String pathSortides = "/api/token/sortides";
const String pathPagamentSortides = "/sortides/pagoOnlineApi/";


const String recuperarUrl =
    "$baseUrl/usuaris/sendPasswdByEmail/";
