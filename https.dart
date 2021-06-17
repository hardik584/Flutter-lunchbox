class MyHttpOverrides extends HttpOverrides{
   @override
   HttpClient createHttpClient(SecurityContext context){
     return super.createHttpClient(context)
       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
   }
 }
 
 Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   final savedThemeMode = await AdaptiveTheme.getThemeMode();
   // ASHISH
   if (!kIsWeb) {
     await Firebase.initializeApp();
   }
   HttpOverrides.global = new MyHttpOverrides();
   }


bool _certificateCheck(X509Certificate cert, String host, int port) =>
     host == 'local.domain.ext'; // <- change

 HttpClient client = new HttpClient()
     ..badCertificateCallback = (_certificateCheck);

     _client.badCertificateCallback =
         (X509Certificate cert, String host, int port) => true;
