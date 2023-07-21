import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:experiance/Widget/MyHomePage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';


void main() async {

  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, // Hide the debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
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
          Text('votre agence immobilière plus près de vous'),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 235, 16, 19),
      nextScreen: MyHomePage(),
      splashIconSize: 800.0, // Corrected the splashIconSize
      duration: 3000,
      splashTransition: SplashTransition.sizeTransition,
      //pageTransitionType: PageTransitionType.topToBottom,
      animationDuration: const Duration(),
    );
  }
}
