import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Google Sign In
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) throw Exception('Google sign in aborted');

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credentials
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      throw Exception('Failed to sign in with Google: ${e.toString()}');
    }
  }

  // Facebook Sign In
  Future<UserCredential> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult result = await FacebookAuth.instance.login();
      
      if (result.status != LoginStatus.success) {
        throw Exception('Facebook sign in failed: ${result.message}');
      }

      // Create a credential from the access token
      final OAuthCredential credential = 
          FacebookAuthProvider.credential(result.accessToken!.token);

      // Sign in to Firebase with the Facebook credentials
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      throw Exception('Failed to sign in with Facebook: ${e.toString()}');
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
        FacebookAuth.instance.logOut(),
      ]);
    } catch (e) {
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }

  // Get current user
  User? get currentUser => _auth.currentUser;
}