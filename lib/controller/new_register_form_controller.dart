import 'package:flutter/material.dart';

class NewRegisterFormController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController hourController = TextEditingController();

  String? nameError;
  String? hourError;
  bool isSwitchOn = false;

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
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
    return null;
  }

  String? validateHour(String? value, bool isInputChecked) {
    if(isInputChecked){
      if (value == null || value.isEmpty) {
        return 'Campo obrigatório';
      }
    }
    return null;
  }

  void dispose() {
    nameController.dispose();
    hourController.dispose();
  }

  void clear() {
    nameController.clear();
    hourController.clear();
  }

  bool validateForm() {
    nameController.text = nameController.text.trim();
    nameError = validateName(nameController.text);
    hourError = validateHour(hourController.text, isSwitchOn);
    return nameError == null && hourError == null;
  }

  void sendRegister(BuildContext context) {
    //todo
  }

  void changeSwitch() {
    isSwitchOn = !isSwitchOn;
  }

  bool isBtnEnable() {
    if (!isSwitchOn) {
      if(nameController.text.isEmpty){
        return false;
      }
      return true;
    }
    if (isSwitchOn) {
      if(nameController.text.isEmpty || hourController.text.isEmpty){
        return false;
      }
      return true;
    }
    return true;
  }
}