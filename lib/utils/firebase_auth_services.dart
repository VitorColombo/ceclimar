import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendPasswordResetEmail(String email, context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      throw Exception('Erro ao enviar email de recuperação de senha. Por favor, tente novamente.');
    }
  }

  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      throw Exception('Erro ao criar usuário. Por favor, tente novamente.');
    }
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      throw Exception('Erro ao fazer login. Por favor, tente novamente.');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Erro ao fazer logout. Por favor, tente novamente.');
    }
  }

  User? get currentUser {
    return _auth.currentUser;
  }
}