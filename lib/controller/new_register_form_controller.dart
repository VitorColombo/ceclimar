import 'package:flutter/material.dart';

class NewRegisterFormController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController speciesController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController beachSpotController = TextEditingController();
  final TextEditingController obsController = TextEditingController();
  final TextEditingController familyController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController orderController = TextEditingController();

  String? nameError;
  String? hourError;
  String? speciesError;
  String? cityError;
  String? beachSpotError;
  String? obsError;
  String? familyError;
  String? genderError;
  String? orderError;
  bool isSwitchOn = false;

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

  bool validateTechnicalForm() {
    nameController.text = nameController.text.trim();
    speciesController.text = speciesController.text.trim();
    cityController.text = cityController.text.trim();
    beachSpotController.text = beachSpotController.text.trim();
    obsController.text = obsController.text.trim();
    familyController.text = familyController.text.trim();
    genderController.text = genderController.text.trim();
    orderController.text = orderController.text.trim();

    nameError = validateName(nameController.text);
    hourError = validateHour(hourController.text, isSwitchOn);
    speciesError = validateSpecies(speciesController.text);
    cityError = validateCity(cityController.text);
    beachSpotError = validateBeachSpot(beachSpotController.text);
    obsError = validateObs(obsController.text);
    familyError = validateFamily(familyController.text);
    genderError = validateGender(genderController.text);
    orderError = validateOrder(orderController.text);
    return nameError == null && hourError == null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    final RegExp regex = RegExp(r'^[a-zA-Z\s]*$');
    if (!regex.hasMatch(value)) {
      return 'Caractere inválido';
    }
    if (value.length < 3) {
      return 'Caracteres mínimos: 3';
    }
    if (value.length > 40) {
      return 'Caracteres máximos: 40';
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

  String? validateSpecies(String species) {
    final RegExp regex = RegExp(r'^[a-zA-Z\s]*$');
    if (species.length < 5) {
      return 'Caracteres mínimos: 5';
    }
    if (!regex.hasMatch(species)) {
      return 'Caractere inválido';
    }
    return null;
  }

  String? validateGender(String gender) {
    final RegExp regex = RegExp(r'^[a-zA-Z\s]*$');
    if (gender.isNotEmpty) {
      if (gender.length < 3) {
        return 'Caracteres mínimos: 3';
      }
      if (!regex.hasMatch(gender)) {
        return 'Caractere inválido';
      }
    }
    return null;
  }

  String? validateFamily(String family) {
    final RegExp regex = RegExp(r'^[a-zA-Z\s]*$');
    if (family.isNotEmpty) {
      if (family.length < 3) {
        return 'Caracteres mínimos: 3';
      }
      if (!regex.hasMatch(family)) {
        return 'Caractere inválido';
      }
    }
    return null;
  }

  String? validateCity(String city) {
    final RegExp regex = RegExp(r'^[a-zA-Z\s]*$');
    if (city.length < 3) {
      return 'Caracteres mínimos: 3';
    }
    if (!regex.hasMatch(city)) {
      return 'Caractere inválido';
    }
    return null;
  }

  String? validateBeachSpot(String beachSpot) {
    final RegExp regex = RegExp(r'^[0-9]*$');
    if (beachSpot.isNotEmpty) {
      if (!regex.hasMatch(beachSpot)) {
        return 'Apenas número';
      }
    }
    return null;
  }

  String? validateObs(String obs) {
    if (obs.isNotEmpty) {
      if (obs.length < 5) {
        return 'Caracteres mínimos: 5';
      }
    }
    return null;
  }

  String? validateOrder(String order) {
    final RegExp regex = RegExp(r'^[a-zA-Z\s]*$');
    if (order.isNotEmpty) {
      if (order.length < 3) {
        return 'Caracteres mínimos: 3';
      }
      if (!regex.hasMatch(order)) {
        return 'Caractere inválido';
      }
    }
    return null;
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
    if(nameController.text.isEmpty || hourController.text.isEmpty){
      return false;
    }
    return true;
  }

  bool isBtnEnabledTechnical() {
    if (!isSwitchOn) {
      if(nameController.text.isEmpty ||
        speciesController.text.isEmpty ||
        cityController.text.isEmpty){
        return false;
      }
      return true;
    }
    if(nameController.text.isEmpty || hourController.text.isEmpty){
      return false;
    }
    return true;
  }
}