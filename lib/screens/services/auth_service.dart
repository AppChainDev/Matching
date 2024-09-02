import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  signInWithGoogle() async{
    try {
      // Create an instance of GoogleSignIn
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      await googleSignIn.signOut();
      // Prompt the user to select a Google account
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // The user canceled the sign-in process
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential using the tokens
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in the user with Firebase using the credential
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Get the user information
      User? user = userCredential.user;

      // Collect user information and tokens
      Map<String, dynamic> userInfo = {
        'displayName': user?.displayName,
        'email': user?.email,
        'photoURL': user?.photoURL,
        'uid': user?.uid,
        'accessToken': googleAuth.accessToken,
        'idToken': googleAuth.idToken,
      };
      return userInfo;

    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth errors
      print('FirebaseAuthException: ${e.message}');
      return null;
    } catch (e) {
      // Handle other types of errors
      print('Exception: $e');
      return null;
    }
  }
}