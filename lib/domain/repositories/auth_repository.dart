abstract class AuthRepository {
  Future<bool> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<bool> signInWithGoogle();

  bool isLoggedIn();

  Future<bool> resetPassword({
    required String email,
  });
}
