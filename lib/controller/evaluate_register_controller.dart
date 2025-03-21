import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/models/animal_response.dart';
import 'package:tcc_ceclimar/models/animal_update_request.dart';
import 'package:tcc_ceclimar/models/register_response.dart';
import 'package:tcc_ceclimar/models/update_register_request.dart';
import 'package:tcc_ceclimar/pages/base_page.dart';
import 'package:tcc_ceclimar/utils/animals_service.dart';

class EvaluateRegisterFormController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController speciesController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController beachSpotController = TextEditingController();
  final TextEditingController obsController = TextEditingController();
  final TextEditingController familyController = TextEditingController();
  final TextEditingController genuController = TextEditingController();
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
  String? genuError;
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
    genuController.text = genuController.text.trim();
    orderController.text = orderController.text.trim();

    nameError = validateName(nameController.text);
    classError = validateClass(classController.text);
    speciesError = validateSpecies(speciesController.text);
    obsError = validateObs(obsController.text);
    familyError = validateFamily(familyController.text);
    genuError = validateGender(genuController.text);
    orderError = validateOrder(orderController.text);

    return nameError == null &&
        speciesError == null &&
        classError == null &&
        obsError == null &&
        familyError == null &&
        genuError == null &&
        orderError == null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    final RegExp regex = RegExp(r'^[\p{L}\s\-]+$', unicode: true);
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

  String? validateSpecies(String text) {
    if (text.isNotEmpty) {
      final RegExp regex = RegExp(r'^[\p{L}\s\-]+$', unicode: true);
      if (text.length < 3) {
        return 'Caracteres mínimos: 3';
      }
      if (!regex.hasMatch(text)) {
        return 'Caractere inválido';
      }
    }
    return null;
  }

  String? validateGender(String text) {
    if (text.isNotEmpty) {
      final RegExp regex = RegExp(r'^[\p{L}\s\-]+$', unicode: true);
      if (text.length < 3) {
        return 'Caracteres mínimos: 3';
      }
      if (!regex.hasMatch(text)) {
        return 'Caractere inválido';
      }
    }
    return null;
  }

  String? validateFamily(String text) {
    if (text.isNotEmpty) {
      final RegExp regex = RegExp(r'^[\p{L}\s\-]+$', unicode: true);
      if (text.length < 3) {
        return 'Caracteres mínimos: 3';
      }
      if (!regex.hasMatch(text)) {
        return 'Caractere inválido';
      }
    }
    return null;
  }

  String? validateOrder(String? order) {
    if (order == null || order.isEmpty) {
      return 'Campo obrigatório';
    }
    final RegExp regex = RegExp(r'^[\p{L}\s\-]+$', unicode: true);
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
    final RegExp regex = RegExp(r'^[\p{L}\s\-]+$', unicode: true);
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
      if (text.length > 600) {
        return 'Caracteres máximos: 600';
      }
    }
    return null;
  }

  Future<void> sendEvaluation(BuildContext context, RegisterResponse register) async {
    if (validateForm()) {
        try {
          sendTechnicalEvaluation(register);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Avaliação enviada com sucesso!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: "Inter"
                ),
              ),
              backgroundColor: Colors.green,
            )
          );
            Navigator.pushReplacementNamed(context, BasePage.routeName);
        } catch (e) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Falha ao enviar avaliação: ${e.toString()}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: "Inter",
                ),
              ),
              backgroundColor: Colors.red,
            ),
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

  void sendTechnicalEvaluation(RegisterResponse register) async {
    final updatedRegister = UpdateRegisterRequest(
        animal: AnimalUpdateRequest(
        popularName: nameController.text,
        species: speciesController.text,
        classe: classController.text,
        order: orderController.text,
        family: familyController.text,
        genus: genuController.text,
      ),
      status: "Validado",
      sampleState: int.tryParse(animalStateController.text) ?? 0,
      specialistReturn: obsController.text,
    );

    try {
      final response = await FirebaseFirestore.instance
          .collection('users')
          .doc(register.userId)
          .collection('registers')
          .where('registerNumber', isEqualTo: register.registerNumber)
          .get();

      if (response.docs.isNotEmpty) {
        final docId = response.docs.first.id;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(register.userId)
            .collection('registers')
            .doc(docId)
            .update(updatedRegister.toJson());

        AnimalService animalService = AnimalService();
        AnimalResponse? animal = await animalService.getAnimalFromSpecies(speciesController.text);
        if(animal != null){
          await FirebaseFirestore.instance
              .collection('animals')
              .doc(animal.id.toString())
              .update({
            'quantity': FieldValue.increment(1)
          });
        } else{
            throw Exception('Falha ao atualizar quantidade de animais encontrados');
        }
      } else {
        throw Exception('Registro não encontrado');
      }
    } catch (e) {
      rethrow;
    }
  }
}