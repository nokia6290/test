abstract class AuthProvider {
  /// Returns current user id, if successful.
  Future<String> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Returns current user id, if successful.
  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<String?> signInWithGoogle();

  Future<String?> signInWithApple();

  Stream<String?> getUserIdStream();

  Future<void> logOut();

  Future<void> resetPassword(String email);
}
