//import 'package:animated_splash_screen/animated_splash_screen.dart';
//import 'package:experiance/Debut_de_laplication/login.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:experiance/Home/wrapper.dart';
import 'package:experiance/firebase/authentication.dart';
import 'package:experiance/model/Art.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'Debut_de_laplication/login.dart';
import 'Home/MyHomePage.dart';
import 'Home/profile/Profile.dart';
import 'Widget/Art/Art_detail/Detail.dart';
import 'firebase/dbservices.dart';
import 'firebase/firebase_options.dart';


void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    if (kDebugMode) {
      print(e);
      print('Firebase initialization error');
    }

  }



  runApp(
    MultiProvider(
      providers: [
        StreamProvider.value(
          initialData: null,
          value: AuthService().user,
        ),
        StreamProvider<List<Art>>.value(
            initialData: const [],
            value: DbService().getArtByuserID(),
        )
      ],
      child: const MyApp(),
    )
  );
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SOKO',
      debugShowCheckedModeBanner: false, // Hide the debug banner
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => const SplashScreen(),//const Wrapper(),
        '/profile' : (context) => const Profile(),
        '/detail' : (context) => const Detail(),
      },
      //home: const Wrapper(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Lottie.asset('assets/SOKO.json'),
          const Text(
            'SOKO',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Text('votre agence immobilière plus près de vous'),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 235, 16, 19),
       nextScreen: const Wrapper(), //const login(),
      splashIconSize: 800.0, // Corrected the splashIconSize
      duration: 4000,
      splashTransition: SplashTransition.sizeTransition,
      //pageTransitionType: PageTransitionType.topToBottom,
      animationDuration: const Duration(),
    );
  }
}
