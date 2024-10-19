import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class IconAuth {

  signInWithGoogle() async {
    //To Selecte Acount
    final GoogleSignInAccount? user = await GoogleSignIn().signIn();

    //Authenticate Request
    final GoogleSignInAuthentication auth = await user!.authentication;

    //Create credential for log in
    final credential = GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken
    );

    //Log In
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

}