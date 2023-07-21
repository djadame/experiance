import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //connexion avec google
  Future<UserCredential?> signInWithGoogle() async{
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

   /* try{
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
      );
      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }*/
  }

  //permet d'obtenir l'etat de connexion de l'utilisateur
  Stream<User?> get user => _auth.authStateChanges();
}