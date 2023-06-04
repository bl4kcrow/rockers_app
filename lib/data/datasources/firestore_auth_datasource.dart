import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:rockers_app/domain/domain.dart';

class FirestoreAuthDatasource implements AuthDatasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<bool> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    bool result = false;

    await _auth
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((_) => result = true)
        .onError(
          (_, __) => result = false,
        );

    return result;
  }

  @override
  bool isLoggedIn() {
    bool result = false;

    _auth.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          result = false;
        } else {
          result = true;
        }
      },
    );

    return result;
  }

  @override
  Future<bool> resetPassword({
    required String email,
  }) async {
    bool result = false;

    _auth
        .sendPasswordResetEmail(
          email: email,
        )
        .then((_) => result = true)
        .onError(
          (_, __) => result = false,
        );

    return result;
  }

  @override
  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    bool result = false;

    await _auth
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((_) => result = true)
        .onError(
          (_, __) => result = false,
        );

    return result;
  }

  @override
  Future<bool> signInWithGoogle() async {
    bool result = false;

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await _auth
        .signInWithCredential(credential)
        .then((_) => result = true)
        .catchError(
          (_, __) => result = false,
        );

    return result;
  }
}
