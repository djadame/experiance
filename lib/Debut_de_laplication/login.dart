import 'package:experiance/firebase/authentication.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login ({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool inLoginProcess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: const EdgeInsets.all(50),
        alignment: Alignment.center,
        child: inLoginProcess
            ? const CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => siginWithGoogle(),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(width: 10),
                  Text('Sign in with Google'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  siginWithGoogle() async {
    setState(() {
      inLoginProcess = true;
      //AuthService().signInWithGoogle();
    });
    try {
      //attempt to sign in with google
      await AuthService().signInWithGoogle();
      //connexion avec google
      setState(() {
        inLoginProcess = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        inLoginProcess = false;
      });
    }
  }
}