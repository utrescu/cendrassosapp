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
// const String baseUrl = "https://djauproves.cendrassos.net/api/token";
const String baseUrl = "http://192.168.1.141:8080/api";
// La URL ha d'acabar amb una barra
const String endBaseUrl = "/";

const bool loginWithQR = true;

// QR Login
const String qrToken = "/token/capture_token_api";
// Normal Login
const String pathLogin = "/api-token-auth";
const String tokenRefresh = "/api-token-refresh";

const String pathNotificacions = "/notificacions/mes";
const String pathNews = "/notificacions/news";
const String pathProfile = "/alumnes/dades";

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

// Textos dels missatges d'error

const String missatgeCarregantDades = "Carregant dades";
const String missatgeTornaAProvar = "Torna-ho a provar";
const String missatgeOk = "D'acord";

const String errorCarregant =
    "ERROR carregant les dades. Torna-ho a provar més tard";
