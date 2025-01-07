import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tcc_ceclimar/models/simple_register_request.dart';
import 'package:tcc_ceclimar/models/technical_register_request.dart';
import 'package:tcc_ceclimar/pages/base_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:tcc_ceclimar/models/local_register.dart';
import 'package:tcc_ceclimar/utils/register_status.dart';

enum RegisterError {
  requiredField('Campo obrigatório'),
  invalidCharacter('Caractere inválido'),
  minimumCharacter('Caracteres mínimos: '),
  maximumCharacter('Caracteres máximos: '),
  imageError('É obrigatório o envio de, no mínimo, uma imagem'),
  onlyNumber('Apenas número');

   final String message;
   const RegisterError(this.message);
}

class NewRegisterFormController {
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  File? _image;
  File? _image2;
  String? currentAddress;
  Position? currentPosition;
  final String newRegisterEndpoint = '';
  bool isSwitchOn = false;
  final Box<LocalRegister> _registerBox = Hive.box<LocalRegister>('registers');
  
  String? nameError;
  String? hourError;
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
  
  final List<SimpleRegisterRequest> _simpleMockData = [];
  final List<TechnicalRegisterRequest> _technicalMockData = [];

  List<TechnicalRegisterRequest> get technicalMockData{
    return [..._technicalMockData];
  }

  List<SimpleRegisterRequest> get simpleMockData{
    return [..._simpleMockData];
  }

  void dispose() {
      nameController.dispose();
      hourController.dispose();
      speciesController.dispose();
      cityController.dispose();
      beachSpotController.dispose();
      classController.dispose();
      orderController.dispose();
      familyController.dispose();
      genuController.dispose();
      obsController.dispose();
  }

  void clear() {
    nameController.clear();
    hourController.clear();
  }

  bool validateForm() {
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
    genuController.text = genuController.text.trim();
    orderController.text = orderController.text.trim();

    nameError = validateName(nameController.text);
    hourError = validateHour(hourController.text, isSwitchOn);
    speciesError = validateSpecies(speciesController.text);
    cityError = validateCity(cityController.text);
    beachSpotError = validateBeachSpot(beachSpotController.text);
    obsError = validateObs(obsController.text);
    familyError = validateFamily(familyController.text);
    genuError = validateGenu(genuController.text);
    orderError = validateOrder(orderController.text);
    imageError = validateImages();

    return nameError == null && hourError == null && validateImages() == null; 
  }

  String? validateImages() {
    if (_image == null && _image2 == null) {
      return RegisterError.imageError.message;
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return RegisterError.requiredField.message;
    }
    final RegExp regex = RegExp(r'^[\p{L}\s]+$', unicode: true);
    if (!regex.hasMatch(value)) {
      return RegisterError.invalidCharacter.message;
    }
    if (value.length < 3) {
      return '${RegisterError.minimumCharacter.message} 3';
    }
    if (value.length > 40) {
      return '${RegisterError.maximumCharacter.message} 40';
    }
    return null;
  }

  String? validateHour(String? value, bool isInputChecked) {
    if(isInputChecked){
      if (value == null || value.isEmpty) {
        return RegisterError.requiredField.message;
      }
    }
    return null;
  }

  String? validateSpecies(String species) {
    final RegExp regex = RegExp(r'^[\p{L}\s]+$', unicode: true);
    if (species.isNotEmpty){
      if (species.length < 5) {
         return '${RegisterError.minimumCharacter.message} 5';
      }
      if (!regex.hasMatch(species)) {
         return RegisterError.invalidCharacter.message;
      }
    }
    return null;
  }

  String? validateGenu(String genu) {
    final RegExp regex = RegExp(r'^[\p{L}\s]+$', unicode: true);
    if (genu.isNotEmpty) {
      if (genu.length < 3) {
        return '${RegisterError.minimumCharacter.message} 3';
      }
      if (!regex.hasMatch(genu)) {
        return RegisterError.invalidCharacter.message;
      }
    }
    return null;
  }

  String? validateFamily(String family) {
    final RegExp regex = RegExp(r'^[\p{L}\s]+$', unicode: true);
    if (family.isNotEmpty) {
      if (family.length < 3) {
        return '${RegisterError.minimumCharacter.message} 3';
      }
      if (!regex.hasMatch(family)) {
        return RegisterError.invalidCharacter.message;
      }
    }
    return null;
  }

  String? validateCity(String city) {
    final RegExp regex = RegExp(r'^[\p{L}\s]+$', unicode: true);
    if (city.length < 3) {
      return '${RegisterError.minimumCharacter.message} 3';
    }
    if (!regex.hasMatch(city)) {
      return RegisterError.invalidCharacter.message;
    }
    return null;
  }

  String? validateBeachSpot(String beachSpot) {
      final RegExp regex = RegExp(r'^[0-9]*$');
    if (beachSpot.isNotEmpty) {
      if (!regex.hasMatch(beachSpot)) {
        return RegisterError.onlyNumber.message;
      }
    }
    return null;
  }

  String? validateObs(String obs) {
    if (obs.isNotEmpty) {
      if (obs.length < 5) {
       return '${RegisterError.minimumCharacter.message} 5';
      }
    }
    return null;
  }

  String? validateOrder(String order) {
    final RegExp regex = RegExp(r'^[\p{L}\s]+$', unicode: true);
    if (order.isNotEmpty) {
      if (order.length < 3) {
       return '${RegisterError.minimumCharacter.message} 3';
      }
      if (!regex.hasMatch(order)) {
        return RegisterError.invalidCharacter.message;
      }
    }
    return null;
  }

  void setImage(File? image) {
    _image = image;
  }

  void setImage2(File? image) {
    _image2 = image;
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
      if(nameController.text.isEmpty || beachSpotController.text.isEmpty ||
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
    if (validateForm()) {
      final connectivityResult = await (Connectivity().checkConnectivity());
      String name = nameController.text;
      String hour = hourController.text;
      bool witnessed = isSwitchOn;
      await getPosition();
      if (currentPosition != null) {
        double latitude = currentPosition!.latitude;
        double longitude = currentPosition!.longitude;
           final registerData = {
             "name": name,
             "hour": hour,
             "witnessed": witnessed,
             "latitude": latitude,
             "longitude": longitude,
           };
          if (connectivityResult == ConnectivityResult.none) {
             _queueRegister(registerData, 'simple', _image, _image2);
            _showSuccessMessage(context, 'Registro salvo localmente. Será enviado quando a internet voltar.');
          } else {
            try {
              final response = await sendSimpleRegisterToApi(
                name,
                hour,
                witnessed,
                latitude,
                longitude,
              );
              if (response != null) {
                _showSuccessMessage(context, 'Registro enviado com sucesso!');
                Navigator.pushNamedAndRemoveUntil(context, BasePage.routeName, (Route<dynamic> route) => false, arguments: 0);
              } else {
                _handleError(context, 'Falha ao enviar o registro.');
              }
           } catch (e) {
              _handleError(context, 'Falha ao enviar registro: $e');
           }
        }
      }
    } else {
      if (imageError != null) {
        _handleError(context, imageError!);
      }
    }
  }

  Future<void> sendTechnicalRegister(BuildContext context, Function getPosition) async {
      if (validateTechnicalForm()) {
        final connectivityResult = await (Connectivity().checkConnectivity());
        String name = nameController.text;
        String hour = hourController.text;
        bool witnessed = isSwitchOn;
        String species = speciesController.text;
        String city = cityController.text;
        String beachSpot = beachSpotController.text;
        String obs = obsController.text;
        String family = familyController.text;
        String genu = genuController.text;
        String order = orderController.text;
        String classe = classController.text;
          await getPosition();

      if (currentPosition != null) {
        double latitude = currentPosition!.latitude;
        double longitude = currentPosition!.longitude;
          final registerData = {
              "name": name,
              "hour": hour,
              "witnessed": witnessed,
              "species": species,
              "city": city,
              "beachSpot": beachSpot,
              "obs": obs,
              "family": family,
              "genu": genu,
              "order": order,
              "classe": classe,
              "latitude": latitude,
              "longitude": longitude
          };
        if (connectivityResult == ConnectivityResult.none) {
          _queueRegister(registerData, 'technical', _image, _image2);
           _showSuccessMessage(context, 'Registro salvo localmente. Será enviado quando a internet voltar.');
          } else {
           try {
             final response = await sendTechnicalRegisterToApi(
               name,
               hour,
               witnessed,
               species,
               city,
               beachSpot,
               obs,
               family,
               genu,
               order,
               classe,
               latitude,
               longitude,
             );
             if (response != null) {
               _showSuccessMessage(context, 'Registro enviado com sucesso!');
              Navigator.pushNamedAndRemoveUntil(context, BasePage.routeName, (Route<dynamic> route) => false, arguments: 0);
             } else {
                _handleError(context, 'Falha ao enviar o registro.');
              }
           } catch (e) {
              _handleError(context, 'Falha ao enviar o registro: $e');
           }
          }
      }
    } else {
       if (imageError != null) {
         _handleError(context, imageError!);
        }
    }
  }

  Future<SimpleRegisterRequest?> sendSimpleRegisterToApi(
      String name, String hour, bool witnessed,
      double latitude, double longitude,) async {
    User user = FirebaseAuth.instance.currentUser!;
    try{
      final String imageUrl = await uploadImageToFirebaseStorage(_image!);
      final String? imageUrl2 = _image2 != null ? await uploadImageToFirebaseStorage(_image2!) : null;
      final int registerId = await getNextRegisterId();

      final newRegister = SimpleRegisterRequest(
        userId: user.uid,
        registerNumber: registerId.toString(),
        authorName: user.displayName ?? 'Anônimo',
        animal: {
          "popularName": name,
        },
        hour: hour,
        witnessed: witnessed,
        location: {
          "latitude": latitude.toString(),
          "longitude": longitude.toString(),
        },
        registerImageUrl: imageUrl,
        registerImageUrl2: imageUrl2,
        date: DateTime.now(),
        status: 'Enviado',
      );

      await addRegisterToFirestore(
        user.uid,
        newRegister.toJson(),
      );

      return newRegister;
    } catch(e){
      debugPrint("error when sending simple register $e");
      rethrow;
    }
  }

  Future<TechnicalRegisterRequest?> sendTechnicalRegisterToApi(
      String name, String hour, bool witnessed, String species, String city,
      String beachSpot, String obs, String family, String genu, String order,
      String classe, double latitude, double longitude) async {     
    User user = FirebaseAuth.instance.currentUser!;
    try{
      final String imageUrl = await uploadImageToFirebaseStorage(_image!);
      final String? imageUrl2 = _image2 != null ? await uploadImageToFirebaseStorage(_image2!) : null;
      final int registerId = await getNextRegisterId();

      final newRegister = TechnicalRegisterRequest(
        userId: user.uid,
        registerNumber: registerId.toString(),
        authorName: user.displayName ?? 'Anônimo',
        animal: {
          "popularName": name,
          "species": species,
          "family": family,
          "genus": genu,
          "order": order,
          "class": classe,
        },
        hour: hour,
        witnessed: witnessed,
        location: {
          "latitude": latitude.toString(),
          "longitude": longitude.toString(),
        },
        city: city,
        beachSpot: beachSpot,
        obs: obs,
        registerImageUrl: imageUrl,
        registerImageUrl2: imageUrl2,
        date: DateTime.now(),
        status: 'Enviado',
      );
      await addRegisterToFirestore(
        user.uid,
        newRegister.toJson(),
      );

      return newRegister;
    } catch(e){
      debugPrint("error when sending technical register $e");
      rethrow;
    }
  }

  Future<void> addRegisterToFirestore(String userId, Map<String, dynamic> registerData) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('registers')
          .add(registerData);
    } catch (e) {
      debugPrint('Erro ao adicionar registro no Firestore: $e');
      throw Exception('Falha ao salvar o registro no Firestore');
    }
  }

Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final uploadTask = storageRef.child('registers/$fileName.jpg').putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() => {});
      final imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } on FirebaseException catch (e) {
      debugPrint('Erro ao enviar imagem para o Firebase Storage: $e');
      throw Exception('Falha ao enviar a imagem para o Firebase Storage: ${e.message ?? 'Erro desconhecido'}');
    }
    catch (e){
       debugPrint('Erro ao enviar imagem para o Firebase Storage: $e');
      throw Exception('Falha ao enviar a imagem para o Firebase Storage: ${e.toString()}');
    }
  }

  Future<int> getNextRegisterId() async {
    final registerCounter = FirebaseFirestore.instance
      .collection('counters')
      .doc('registerCounter');

    try {
      final snapshot = await registerCounter.get();
      if (!snapshot.exists) {
        await registerCounter.set({'count': 1});
        return 1;
      }

      final newCount = snapshot.data()!['count'] + 1;
      await registerCounter.update({'count': FieldValue.increment(1)});
      return newCount;
    } catch (e) {
      print('Erro ao incrementar contador: $e');
      throw Exception('Erro ao obter próximo ID');
    }
  }

 void _queueRegister(Map<String, dynamic> registerData, String registerType, File? image, File? image2) {
      final newRegister = LocalRegister(
        registerType: registerType,
        data: registerData,
        status: RegisterStatus.pending,
        registerImagePath: image?.path,
        registerImagePath2: image2?.path
      );
        _registerBox.add(newRegister);
    }
  
  void _showSuccessMessage(BuildContext context, String message){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(message,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: "Inter"
                ),
            ),
            backgroundColor: Colors.green,
          )
      );
  }
  
  Future<void> _handleError(BuildContext context, dynamic error) {
    String message;
    if (error is PlatformException) {
      message = error.message ?? 'Erro desconhecido';
    } else if (error is Exception) {
      message = error.toString();
    } else {
      message = 'Erro desconhecido';
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white, fontFamily: 'Inter'),
        ),
        backgroundColor: Colors.red,
      ),
    );
    throw Exception(message);
  }
  
  Future<void> retryPendingRegisters() async {
    _checkHiveData();
    final pendingRegisters = _registerBox.values
          .where((register) => register.status == RegisterStatus.pending)
          .toList();
    for(final register in pendingRegisters) {
      int retryCount = 0;
      bool isSent = false;
      while(retryCount < 3 && !isSent){
        final connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult != ConnectivityResult.none) {
          try {
              _image = register.registerImagePath != null ? File(register.registerImagePath!): null;
            _image2 = register.registerImagePath2 != null ? File(register.registerImagePath2!): null;
            if(register.registerType == 'simple') {
                await sendSimpleRegisterToApi(
                  register.data['name'],
                  register.data['hour'],
                  register.data['witnessed'],
                  register.data['latitude'],
                  register.data['longitude'],
                );
              } else if(register.registerType == 'technical') {
                  await sendTechnicalRegisterToApi(
                  register.data['name'],
                  register.data['hour'],
                  register.data['witnessed'],
                  register.data['species'],
                  register.data['city'],
                  register.data['beachSpot'],
                  register.data['obs'],
                  register.data['family'],
                  register.data['genu'],
                  register.data['order'],
                  register.data['classe'],
                  register.data['latitude'],
                  register.data['longitude'],
                );
              }
                _updateRegisterStatus(register, RegisterStatus.sent);
              isSent = true;
          } catch (e) {
                _updateRegisterStatus(register, RegisterStatus.error);
                await Future.delayed(Duration(seconds: (retryCount + 1) * 5 ));
                retryCount++;
                debugPrint('Erro ao enviar registro: $e, tentando novamente em ${retryCount*5} segundos');
          }
        } else {
          await Future.delayed(const Duration(seconds: 10));
          debugPrint('Sem conexão com a internet, tentando novamente em 10 segundos');
        }
      }
    }
  }

  void _updateRegisterStatus(LocalRegister register, RegisterStatus status) {
    final index = _registerBox.values.toList().indexOf(register);
    if(index != -1){
        _registerBox.putAt(index, LocalRegister(registerType: register.registerType, data: register.data, status: status));
    }
  }

  void initConnectivityListener(){
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none){
        retryPendingRegisters();
      }
    });
  }

   void _checkHiveData() {
      final registerBox = Hive.box<LocalRegister>('registers');
        print('------- Hive Data -------');
        for (var register in registerBox.values) {
          print(register.toJson());
      }
        print('------- End of Hive Data -------');
    }
}