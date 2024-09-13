import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scalable_flutter_app_pro/core/logger/loggy_types.dart';
import 'package:scalable_flutter_app_pro/core/util/crypto.dart';
import 'package:scalable_flutter_app_pro/feature/auth/provider/auth_provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseAuthProvider extends AuthProvider with ProviderLoggy {
  final _auth = FirebaseAuth.instance;
  final _googleAuth = GoogleSignIn();

  @override
  Stream<String?> getUserIdStream() {
    return _auth.authStateChanges().map((user) => user?.uid);
  }

  @override
  Future<void> logOut() async {
    await _auth.signOut();
    await _googleAuth.signOut();
  }

  @override
  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user!.uid;
    } catch (e, s) {
      loggy.error('signInWithEmailAndPassword error', e, s);
      rethrow;
    }
  }

  @override
  Future<String> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user!.uid;
    } catch (e, s) {
      loggy.error('signUpWithEmailAndPassword error', e, s);
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e, s) {
      loggy.error('resetPassword error', e, s);
      rethrow;
    }
  }

  @override
  Future<String?> signInWithGoogle() async {
    // Trigger the authentication flow
    final googleUser = await _googleAuth.signIn();

    // Obtain the auth details from the request
    final googleAuth = await googleUser?.authentication;
    if (googleAuth == null) {
      return null;
    }

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    final userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user!.uid;
  }

  @override
  Future<String?> signInWithApple() async {
    try {
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final appleAuth = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final token = appleAuth.identityToken;
      if (token == null) {
        return null;
      }

      final credential = OAuthProvider('apple.com').credential(
        idToken: appleAuth.identityToken,
        rawNonce: rawNonce,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user!.uid;
    } on SignInWithAppleAuthorizationException catch (e, s) {
      if (e.code == AuthorizationErrorCode.canceled) {
        // User canceled
        return null;
      }

      loggy.error('signInWithApple error', e, s);
      rethrow;
    }
  }
}
