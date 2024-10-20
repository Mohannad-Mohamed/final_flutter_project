import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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


  signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

}