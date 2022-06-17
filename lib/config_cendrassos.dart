const String appName = "Cendrassos";

// Dades del centre
// -------------------------------------------------------------------
const String nomInstitut = "Institut Cendrassos";
const String missatgeNotificacions = "Notificacions al Djau";

const String djauUrl = "https://djau.cendrassos.net/";
const String recuperarUrl =
    "https://djau.cendrassos.net/usuaris/sendPasswdByEmail/";

// Mesos d'inici i final del curs
// -------------------------------------------------------------------
const int startMonth = 9;
const int endMonth = 6;

// Interval de comprovació de notificacions en minuts
const int intervalNotificacions = 60;

// URLs d'accés a l'API
// -------------------------------------------------------------------
const String baseUrl = "https://djauproves.cendrassos.net/api/token";
// La URL ha d'acabar amb una barra
const String endBaseUrl = "/";

// Punts d'accés a l'API. Normalment no s'hauran de tocar
const String pathLogin = "/login";
const String pathNotificacions = "/notificacions/mes";
const String pathNews = "/notificacions/news";
const String pathProfile = "/alumnes/dades";
