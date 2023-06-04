import 'package:rockers_app/domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.authDatasource);

  final AuthDatasource authDatasource;

  @override
  Future<bool> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await authDatasource.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  bool isLoggedIn() {
    return authDatasource.isLoggedIn();
  }

  @override
  Future<bool> resetPassword({
    required String email,
  }) async {
    return await authDatasource.resetPassword(
      email: email,
    );
  }

  @override
  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await authDatasource.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<bool> signInWithGoogle() async {
    return await authDatasource.signInWithGoogle();
  }
}
