import 'package:flutter/material.dart';

//todo implement this controller for the new register form

class NewRegisterFormController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController horaController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController passConfController = TextEditingController();

  String? nameError;
  String? horaError;
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

  void dispose() {
    nameController.dispose();
    horaController.dispose();
    passController.dispose();
    passConfController.dispose();
  }

  void clear() {
    nameController.clear();
    horaController.clear();
    passController.clear();
    passConfController.clear();
  }
}