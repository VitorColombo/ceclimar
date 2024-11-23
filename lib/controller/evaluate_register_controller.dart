import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/models/update_register_request.dart';

class EvaluateRegisterFormController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController speciesController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController beachSpotController = TextEditingController();
  final TextEditingController obsController = TextEditingController();
  final TextEditingController familyController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController orderController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController animalStateController = TextEditingController();

  final String updateRegisterEndpoint = '';
  
  String? nameError;
  String? speciesError;
  String? cityError;
  String? beachSpotError;
  String? obsError;
  String? familyError;
  String? genderError;
  String? orderError;
  String? classError;
  String? imageError;
  String? image2Error;
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
    speciesController.text = speciesController.text.trim();
    cityController.text = cityController.text.trim();
    beachSpotController.text = beachSpotController.text.trim();
    obsController.text = obsController.text.trim();
    familyController.text = familyController.text.trim();
    genderController.text = genderController.text.trim();
    orderController.text = orderController.text.trim();

    nameError = validateName(nameController.text);
    classError = validateClass(classController.text);
    speciesError = validateSpecies(speciesController.text);
    obsError = validateObs(obsController.text);
    familyError = validateFamily(familyController.text);
    genderError = validateGender(genderController.text);
    orderError = validateOrder(orderController.text);

    return nameError == null &&
        speciesError == null &&
        classError == null &&
        obsError == null &&
        familyError == null &&
        genderError == null &&
        orderError == null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    final RegExp regex = RegExp(r'^[\p{L}\s]+$', unicode: true);
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

  String? validateSpecies(String? species) {
    if (species == null || species.isEmpty) {
      return 'Campo obrigatório';
    }
    final RegExp regex = RegExp(r'^[\p{L}\s]+$', unicode: true);
    if (species.length < 5) {
      return 'Caracteres mínimos: 5';
    }
    if (!regex.hasMatch(species)) {
      return 'Caractere inválido';
    }
    return null;
  }

  String? validateGender(String? gender) {
    if (gender == null || gender.isEmpty) {
      return 'Campo obrigatório';
    }
    final RegExp regex = RegExp(r'^[\p{L}\s]+$', unicode: true);
    if (gender.length < 3) {
      return 'Caracteres mínimos: 3';
    }
    if (!regex.hasMatch(gender)) {
      return 'Caractere inválido';
    }
    return null;
  }

  String? validateFamily(String? family) {
    if (family == null || family.isEmpty) {
      return 'Campo obrigatório';
    }
    final RegExp regex = RegExp(r'^[\p{L}\s]+$', unicode: true);
    if (family.length < 3) {
      return 'Caracteres mínimos: 3';
    }
    if (!regex.hasMatch(family)) {
      return 'Caractere inválido';
    }
    return null;
  }

  String? validateOrder(String? order) {
    if (order == null || order.isEmpty) {
      return 'Campo obrigatório';
    }
    final RegExp regex = RegExp(r'^[\p{L}\s]+$', unicode: true);
    if (order.length < 3) {
      return 'Caracteres mínimos: 3';
    }
    if (!regex.hasMatch(order)) {
      return 'Caractere inválido';
    }
    return null;
  }
  
  String? validateClass(String? text) {
    if (text == null || text.isEmpty) {
      return 'Campo obrigatório';
    }
    final RegExp regex = RegExp(r'^[\p{L}\s]+$', unicode: true);
    if (text.length < 3) {
      return 'Caracteres mínimos: 3';
    }
    if (!regex.hasMatch(text)) {
      return 'Caractere inválido';
    }
    return null;
  }

  String? validateObs(String text) {
    if (text.isNotEmpty) {
      if (text.length < 10) {
        return 'Caracteres mínimos: 10';
      }
      if (text.length > 200) {
        return 'Caracteres máximos: 200';
      }
    }
    return null;
  }

  Future<void> sendEvaluation(BuildContext context) async {
    if (validateForm()) {
        try {
          final response = await sendTechnicalEvaluationToApiMocked();
          if (response != null) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Registro enviado com sucesso!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: "Inter"
                  ),
                ),
                backgroundColor: Colors.green,
              )
            );
          } else {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Falha ao enviar o registro.')),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Falha ao enviar o registro.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Por favor, preencha todos os campos obrigatórios.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: "Inter"
              ),
            ),
            backgroundColor: Colors.red,
          )
        );
      }
  }

  Future<UpdateRegisterRequest?> sendTechnicalEvaluationToApiMocked() async {
    final updatedRegister = UpdateRegisterRequest(
      name: nameController.text,
      species: speciesController.text,
      classe: classController.text,
      order: orderController.text,
      family: familyController.text,
      gender: genderController.text,
      animalStatus: animalStateController.text,
      obs: obsController.text,
    );
    print(updatedRegister.toJson());

    return updatedRegister;
  }
}