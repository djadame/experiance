import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //connexion avec google
  Future<UserCredential?> signInWithGoogle() async {
    //declanche la methode de connexion
    final googleUser = await _googleSignIn.signIn();

    //recupere les informations de l'utilisateur
    final googleAuth = await googleUser!.authentication;

    //creer un nouveau identifiant de connexion
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
    );

    //une foix connecer , renvoyer l'identifiant de connexion de l'utilisateur
    return await _auth.signInWithCredential(credential);
  }
  //permet d'obtenir l'etat de connexion de l'utilisateur
  Stream<User?> get user => _auth.authStateChanges();


  Future logout() async {
    await _googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

}

