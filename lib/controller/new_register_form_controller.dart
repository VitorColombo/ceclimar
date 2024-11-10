import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tcc_ceclimar/models/simple_register_request.dart';
import 'package:tcc_ceclimar/models/technical_register_request.dart';

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
  final TextEditingController classController = TextEditingController();
  File? _image;
  File? _image2;
  String? currentAddress;
  Position? currentPosition;
  final String newRegisterEndpoint = '';
  //todo as validacoes dos controllers do registro tecnico devem ser feitas com base nas regras da biologia presentes no back, se tornarao campos com preenchimento e pesquisa
  
  String? nameError;
  String? hourError;
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

  List<SimpleRegisterRequest> _simpleMockData = [];
  List<TechnicalRegisterRequest> _technicalMockData = [];

  void dispose() {
    nameController.dispose();
    hourController.dispose();
  }

  void clear() {
    nameController.clear();
    hourController.clear();
  }

  bool _validateForm() {
    nameController.text = nameController.text.trim();
    nameError = validateName(nameController.text);
    hourError = validateHour(hourController.text, isSwitchOn);
    imageError = validateImages();

    return nameError == null && hourError == null && validateImages() == null;
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

    return nameError == null && hourError == null && validateImages() == null; //todo
  }

  String? validateImages() {
    if (_image == null && _image2 == null) {
      return 'É obrigatorio o envio de, no mínimo, uma imagem';
    }
    return null;
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

  void setImage(File? image) {
    _image = image;
    print("imagem 1 setada");
  }

  void setImage2(File? image) {
    _image2 = image;
    print("imagem 2 setada");
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

  Future<void> sendSimpleRegister(BuildContext context, Function getPosition) async {
    if (_validateForm()) {
      String name = nameController.text;
      String hour = hourController.text;
      bool witnessed = isSwitchOn;
      await getPosition();

      if (currentPosition != null) {
        double latitude = currentPosition!.latitude;
        double longitude = currentPosition!.longitude;
        print("latitude: $latitude, longitude: $longitude");

        try {
          final response = await sendSimpleRegisterToApiMocked(
            name,
            hour,
            witnessed,
            latitude,
            longitude,
          );
          if (response != null) {
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Falha ao enviar o registro.')),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Falha ao obter a localização: $e')),
          );
        }
      }
    } else {
      if (imageError != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(imageError!),
            backgroundColor: Colors.red,
            ),
        );
      }
    }
  }

  Future<void> sendTechnicalRegister(BuildContext context, Function getPosition) async {
    if (validateTechnicalForm()) {
      String name = nameController.text;
      String hour = hourController.text;
      bool witnessed = isSwitchOn;
      String species = speciesController.text;
      String city = cityController.text;
      String beachSpot = beachSpotController.text;
      String obs = obsController.text;
      String family = familyController.text;
      String gender = genderController.text;
      String order = orderController.text;
      String classe = classController.text;
      await getPosition();

      if (currentPosition != null) {
        double latitude = currentPosition!.latitude;
        double longitude = currentPosition!.longitude;
        print("latitude: $latitude, longitude: $longitude");

        try {
          final response = await sendTechnicalRegisterToApiMocked(
            name,
            hour,
            witnessed,
            species,
            city,
            beachSpot,
            obs,
            family,
            gender,
            order,
            classe,
            latitude,
            longitude,
          );
          if (response != null) {
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Falha ao enviar o registro.')),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Falha ao obter a localização: $e')),
          );
        }
      }
    } else {
      if (imageError != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(imageError!),
            backgroundColor: Colors.red,
            ),
        );
      }
    }
  }

Future<SimpleRegisterRequest?> sendSimpleRegisterToApiMocked(
    String name,
    String hour,
    bool witnessed,
    double latitude,
    double longitude,
  ) async {
    final Uint8List imageBytes = _image != null ? await _image!.readAsBytes() : Uint8List(0);
    final Uint8List image2Bytes = _image2 != null ? await _image2!.readAsBytes() : Uint8List(0);

    final newRegister = SimpleRegisterRequest(
      name: name,
      hour: hour,
      witnessed: witnessed,
      image: base64Encode(imageBytes),
      image2: base64Encode(image2Bytes),
      latitude: latitude.toString(),
      longitude: longitude.toString(),
    );
    _simpleMockData.add(newRegister);

    return newRegister;
  }

  Future<TechnicalRegisterRequest?> sendTechnicalRegisterToApiMocked(
      String name, String hour, bool witnessed, String species, String city,
      String beachSpot, String obs, String family, String gender, String order,
      String classe, double latitude, double longitude
      ) async {

    final Uint8List imageBytes = _image != null ? await _image!.readAsBytes() : Uint8List(0);
    final Uint8List image2Bytes = _image2 != null ? await _image2!.readAsBytes() : Uint8List(0);

    final newRegister = TechnicalRegisterRequest(
      name: name,
      hour: hour,
      witnessed: witnessed,
      species: species,
      city: city,
      beachSpot: beachSpot,
      obs: obs,
      family: family,
      gender: gender,
      order: order,
      classe: classe,
      latitude: latitude.toString(),
      longitude: longitude.toString(),
      image: base64Encode(imageBytes),
      image2: base64Encode(image2Bytes),
    );
    _technicalMockData.add(newRegister);

    return newRegister;
  }
}