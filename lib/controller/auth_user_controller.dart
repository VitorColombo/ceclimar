import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tcc_ceclimar/pages/login.dart';

import '../user_auth/firebase_auth_implementation/firebase_auth_services.dart';

class AuthenticationController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController passConfController = TextEditingController();
  final FirebaseAuthService _auth = FirebaseAuthService();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  String? nameError;
  String? emailError;
  String? passError;
  String? passConfError;

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo não pode ser vazio';
    }
    final RegExp regex = RegExp(r'^[a-zA-Z\s]*$');
    if (!regex.hasMatch(value)) {
      return 'O campo não deve conter caracteres especiais';
    }
    if (value.length < 3) {
      return 'O campo deve conter no mínimo 3 caracteres';
    }
    if (value.length > 40) {
      return 'O campo deve conter no máximo 50 caracteres';
    }
    if (value.split(' ').length < 2) {
      return 'O campo deve conter nome e sobrenome';
    }
    if (value.split(" ").last == '') {
      return 'O campo deve conter nome e sobrenome';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo não pode ser vazio';
    }
    final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) {
      return 'E-mail inválido';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha não pode ser vazia';
    }
    if (value.length < 6) {
      return 'A senha deve conter no mínimo 6 caracteres';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo não pode ser vazio';
    }
    if (value != passController.text) {
      return 'As senhas precisam ser iguais';
    }
    return null;
  }

  bool checkPassMatch() {
    return passController.text == passConfController.text;
  }

  bool validateLogin() {
    emailController.text = emailController.text.trim();
    passController.text = passController.text.trim();
    emailError = validateEmail(emailController.text);
    passError = validatePassword(passController.text);
    return emailError == null && passError == null;
  }

  bool validateSignIn() {
    nameController.text = nameController.text.trim();
    emailController.text = emailController.text.trim();
    passController.text = passController.text.trim();
    passConfController.text = passConfController.text.trim();

    nameError = validateName(nameController.text);
    emailError = validateEmail(emailController.text);
    passError = validatePassword(passController.text);
    passConfError = validateConfirmPassword(passConfController.text);
    return nameError == null &&
        emailError == null &&
        passError == null &&
        passConfError == null &&
        checkPassMatch();
  }

  bool validateForgotPass() {
    emailError = validateEmail(emailController.text);
    passError = validatePassword(passController.text);
    return emailError == null && passError == null;
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    passConfController.dispose();
  }

  void clear() {
    nameController.clear();
    emailController.clear();
    passController.clear();
    passConfController.clear();
  }

  void signUpUser(BuildContext context) async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if(user != null) {
      await user.updateDisplayName(name);
      user.reload;
      user = FirebaseAuth.instance.currentUser;
      
      Navigator.pushNamed(context, LoginPage.routeName);
    } else {
      print('Erro ao cadastrar usuário');
    }
  }

  void signInUser(BuildContext context) async {
    String email = emailController.text;
    String password = passController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if(user != null) {
      //should load the basepage
      Navigator.pushReplacementNamed(context, '/basePage');
    } else {
      print('Erro ao logar');
    }
  }

  void sendPasswordResetEmail() async {
    String email = emailController.text;
    await _auth.sendPasswordResetEmail(email);
  }

  void signOutUser() {
    _auth.signOut();
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        print("User cancelled the sign-in.");
        return;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      
      await FirebaseAuth.instance.signInWithCredential(credential);

      } catch (e) {
        if (e is FirebaseAuthException) {
          print('Google Sign-In Error: ${e.code} - ${e.message}');
        } else {
          print('Error during sign-in: ${e.toString()}');
        }
      }
    }

    User? getCurrentUser() {
      return _auth.currentUser;
  }
}