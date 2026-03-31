import 'package:firebase_auth/firebase_auth.dart';

class AuthDataSource {
  FirebaseAuth get _firebaseAuth => FirebaseAuth.instance;

  Future<UserCredential> login(String email, String password) async {
    try {
      final user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Error de autenticación");
    }
  }

  Future<void> logout() async => await _firebaseAuth.signOut();
}
