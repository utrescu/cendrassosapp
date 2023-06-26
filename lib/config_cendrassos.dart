import 'dart:ui';

const String appName = "Cendrassos";

// Dades del centre
const String nomInstitut = "Institut Cendrassos";
const String missatgeNotificacions = "Notificacions al Djau";

// Mesos d'inici i final del curs
const int startMonth = 9;
const int endMonth = 6;
const int intervalNotificacions =
    15; // Cada quants minuts comprova notificacions

// URLs d'accés a l'API
const String baseUrl = "https://djauproves.cendrassos.net";
// const String baseUrl = "http://192.168.1.141:8080/api";
// La URL ha d'acabar amb una barra
const String endBaseUrl = "/";

const bool loginWithQR = true;

// QR Login
const String qrToken = "/api/token/capture_token_api";
// Normal Login
const String pathLogin = "/api-token-auth";
const String tokenRefresh = "/api-token-refresh";

const String pathNotificacions = "/api/token/notificacions/mes";
const String pathNews = "/api/token/notificacions/news";
const String pathProfile = "/api/token/alumnes/dades";

const String djauUrl = "https://djau.cendrassos.net/api/";
const String recuperarUrl =
    "https://djau.cendrassos.net/usuaris/sendPasswdByEmail/";

// Llista dels tipus de notificacions i els colors amb el que es veuran
// Comprovar que el text és el que arriba en la notificació. Si en calen
// més, s'afegeixen.

Map<String, Color> notificacionsColor = {
  "Falta": const Color(0xFF00BCD4),
  "Justificada": const Color(0xFF4CAF50),
  "Incidència": const Color(0xFFFF9800),
  "Expulsió": const Color(0xFFF44336),
  "Observació": const Color.fromARGB(255, 197, 116, 190),
};

// Constants del calendari
const String calendariCollapsa = "Col·lapsa";
const String calendarMostrames = "Veure el mes";

// Textos dels missatges d'error

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

const String communicationExceptionMessage = "Error durant la comunicació: ";
const String invalidPetitionExceptionMessage = "Petició invàlida: ";
const String notAuthorizedExceptionMessage = "No Autoritzat: ";
const String invalidInputExceptionMessage = "Entrada incorrecta: ";
