import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tcc_ceclimar/models/simple_register_request.dart';
import 'package:tcc_ceclimar/models/technical_register_request.dart';
import 'package:tcc_ceclimar/pages/base_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:tcc_ceclimar/models/local_register.dart';
import 'package:tcc_ceclimar/utils/guarita_data.dart';
import 'package:tcc_ceclimar/utils/register_status.dart';

enum RegisterError {
  requiredField('Campo obrigatório'),
  invalidCharacter('Caractere inválido'),
  minimumCharacter('Caracteres mínimos: '),
  maximumCharacter('Caracteres máximos: '),
  imageError('É obrigatório o envio de uma foto'),
  onlyNumber('Apenas n°'),
  switchError('É necessario preencher no mínimo um dos campos abaixo');

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
  final TextEditingController referencePointController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  File? _image;
  File? _image2;
  String? currentAddress;
  Position? currentPosition;
  GuaritaData? currentGuarita;
  final String newRegisterEndpoint = '';
  bool isHourSwitchOn = false;
  bool isLocalSwitchOn = false;
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
  String? referencePointError;
  String? locationSwitchError;
  
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
      referencePointController.dispose();
  }

  void clear() {
    nameController.clear();
    hourController.clear();
  }

  bool validateForm() {
    nameError = null;
    hourError = null;
    cityError = null;
    beachSpotError = null;
    referencePointError = null;
    imageError = null;
    locationSwitchError = null;

    nameController.text = nameController.text.trim();
    nameError = validateName(nameController.text);
    imageError = validateImages();

    if (isHourSwitchOn) {
      hourError = validateHour(hourController.text);
    }

    if (isLocalSwitchOn) {
      cityController.text = cityController.text.trim();
      beachSpotController.text = beachSpotController.text.trim();
      referencePointController.text = referencePointController.text.trim();

      final isCityEmpty = cityController.text.isEmpty;
      final isBeachSpotEmpty = beachSpotController.text.isEmpty;
      final isReferencePointEmpty = referencePointController.text.isEmpty;

      if (isCityEmpty && isBeachSpotEmpty && isReferencePointEmpty) {
        locationSwitchError = RegisterError.switchError.message;
      } else {
        if (!isCityEmpty) {
           cityError = validateCitySwitch(cityController.text);
        }
        if (!isBeachSpotEmpty) {
          beachSpotError = validateBeachSpotSwitch(beachSpotController.text);
        }
         if (!isReferencePointEmpty) {
           referencePointError = validateReferencePoint(referencePointController.text);
         }
      }
    }
    final isValid = nameError == null &&
        hourError == null &&
        imageError == null &&
        cityError == null &&
        beachSpotError == null &&
        referencePointError == null &&
        locationSwitchError == null;

    return isValid;
  }

  bool validateTechnicalForm() {
    nameError = null;
    hourError = null;
    speciesError = null;
    cityError = null;
    beachSpotError = null;
    obsError = null;
    familyError = null;
    genuError = null;
    orderError = null;
    classError = null;
    imageError = null;
    referencePointError = null;
    locationSwitchError = null;

    nameController.text = nameController.text.trim();
    speciesController.text = speciesController.text.trim();
    cityController.text = cityController.text.trim();
    beachSpotController.text = beachSpotController.text.trim();
    obsController.text = obsController.text.trim();
    familyController.text = familyController.text.trim();
    genuController.text = genuController.text.trim();
    orderController.text = orderController.text.trim();
    classController.text = classController.text.trim();
    referencePointController.text = referencePointController.text.trim();

    nameError = validateName(nameController.text);
    imageError = validateImages();

    if (speciesController.text.isNotEmpty) {
      speciesError = validateSpecies(speciesController.text);
    }
     if (obsController.text.isNotEmpty) {
      obsError = validateObs(obsController.text);
    }
    if (familyController.text.isNotEmpty) {
       familyError = validateFamily(familyController.text);
    }
    if (genuController.text.isNotEmpty) {
       genuError = validateGenu(genuController.text);
    }
    if (orderController.text.isNotEmpty) {
       orderError = validateOrder(orderController.text);
    }

    if (isHourSwitchOn) {
       hourError = validateHour(hourController.text);
    }

    if (isLocalSwitchOn) {
      final isCityEmpty = cityController.text.isEmpty;
      final isBeachSpotEmpty = beachSpotController.text.isEmpty;
      final isReferencePointEmpty = referencePointController.text.isEmpty;

      if (isCityEmpty && isBeachSpotEmpty && isReferencePointEmpty) {
        locationSwitchError = RegisterError.switchError.message;
      } else {
         if (!isCityEmpty) {
           cityError = validateCitySwitch(cityController.text);
         }
         if (!isBeachSpotEmpty) {
           beachSpotError = validateBeachSpotSwitch(beachSpotController.text);
         }
         if (!isReferencePointEmpty) {
           referencePointError = validateReferencePoint(referencePointController.text);
         }

      }
    }

     final isValid = nameError == null &&
        hourError == null &&
        speciesError == null &&
        cityError == null &&
        beachSpotError == null &&
        obsError == null &&
        familyError == null &&
        genuError == null &&
        orderError == null &&
        classError == null &&
        imageError == null &&
        referencePointError == null &&
        locationSwitchError == null;
    return isValid;
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
    final RegExp regex = RegExp(r'^[\p{L}\s\-]+$', unicode: true);
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

  String? validateHour(String? value) {
    if (value == null || value.isEmpty) {
      return RegisterError.requiredField.message;
    }
    return null;
  }

  String? validateCitySwitch(String? value) {
     if (value == null || value.isEmpty) {
       return null;
     }
    final RegExp regex = RegExp(r'^[\p{L}\s\-]+$', unicode: true);
     if (value.length < 3) {
       return '${RegisterError.minimumCharacter.message} 3';
     }
     if (value.length > 50) {
        return '${RegisterError.maximumCharacter.message} 50';
     }
     if (!regex.hasMatch(value)) {
       return RegisterError.invalidCharacter.message;
     }
    return null;
  }


  String? validateBeachSpotSwitch(String value) {
    if (value.isEmpty) {
      return null;
    }
    final RegExp regex = RegExp(r'^[\p{L}\s0-9]+$', unicode: true);
     if (value.length > 10) {
        return '${RegisterError.maximumCharacter.message} 10';
     }
    if (!regex.hasMatch(value)) {
      return RegisterError.invalidCharacter.message;
    }
    return null;
  }

  String? validateReferencePoint(String referencePoint){
    if (referencePoint.isEmpty) {
      return null;
    }
    if (referencePoint.length < 5) {
      return '${RegisterError.minimumCharacter.message} 5';
    }
     if (referencePoint.length > 50) {
        return '${RegisterError.maximumCharacter.message} 50';
     }
    return null;
  }

  String? validateLocationSwitch(String beachSpot, String referencePoint, String city, bool isLocalSwitchOn) {
    if(isLocalSwitchOn){
      if (beachSpot.isEmpty && referencePoint.isEmpty && city.isEmpty) {
        return RegisterError.switchError.message;
      }
      cityError = validateCitySwitch(city);
      if(cityError != null){
        return cityError;
      }
      beachSpotError = validateBeachSpotSwitch(beachSpot);
      if(beachSpotError != null){
        return beachSpotError;
      }
      referencePointError = validateReferencePoint(referencePoint);
      if(referencePointError != null){
        return referencePointError;
      }
      return null;
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
    imageError = null;
    _image = image;
  }

  void setImage2(File? image) {
    imageError = null;
    _image2 = image;
  }

  void changeHourSwitch() {
    isHourSwitchOn = !isHourSwitchOn;
  }

  void changeLocalSwitch() {
    isLocalSwitchOn = !isLocalSwitchOn;
  }

  Future<void> getAddressFromLatLng(Position position, BuildContext context) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      currentAddress ='${place.subAdministrativeArea}, ${place.postalCode}';
    } on PlatformException catch (e) {
      debugPrint('Error when getting the address from lat and long $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
           content: Text(
               'Falha ao obter endereço: ${e.message ?? 'Erro desconhecido'}',
               style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: "Inter"
                 ),
           ),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      print('Erro desconhecido: $e');
    }
  }

  Future<void> sendSimpleRegister(BuildContext context, Function getPosition) async {
      final connectivityResult = await (Connectivity().checkConnectivity());
      String name = nameController.text;
      String hour = hourController.text;
      bool witnessed = isHourSwitchOn;
      String? city = cityController.text;
      String? beachSpot = beachSpotController.text;
      String? referencePoint = referencePointController.text;

      await getPosition();
      if (context.mounted) {
        await getAddressFromLatLng(currentPosition!, context);
      }
      if (currentPosition != null && currentAddress != null) {
        double latitude = currentPosition!.latitude;
        double longitude = currentPosition!.longitude;
        if(!isLocalSwitchOn && cityController.text.isEmpty && beachSpotController.text.isEmpty){
          city = currentAddress!.split(",")[0];
        }
        if(isLocalSwitchOn && beachSpotController.text.isNotEmpty && currentGuarita != null){
          latitude = currentGuarita!.latitude ?? 0.0;
          longitude = currentGuarita!.longitude ?? 0.0;
        }
        final registerData = {
          "name": name,
          "hour": hour,
          "witnessed": witnessed,
          "latitude": latitude,
          "longitude": longitude,
          "city": city,
          "beachSpot": beachSpot,
          "referencePoint": referencePoint
        };
        if (connectivityResult == ConnectivityResult.none) {
          _queueRegister(registerData, 'simple', _image, _image2, context);
          _showSuccessMessage(context, 'Registro salvo localmente. Será enviado quando a internet voltar.');
        } else {
          try {
            final response = await sendSimpleRegisterToApi(
              name,
              hour,
              witnessed,
              latitude,
              longitude,
              city,
              beachSpot,
              referencePoint,
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
  }

  Future<void> sendTechnicalRegister(BuildContext context, Function getPosition) async {
      final connectivityResult = await (Connectivity().checkConnectivity());
      String name = nameController.text;
      String hour = hourController.text;
      bool witnessed = isHourSwitchOn;
      String species = speciesController.text;
      String beachSpot = beachSpotController.text;
      String obs = obsController.text;
      String family = familyController.text;
      String genu = genuController.text;
      String order = orderController.text;
      String classe = classController.text;
      String city = cityController.text;
      await getPosition();
      if (context.mounted) {
        await getAddressFromLatLng(currentPosition!, context);
      }
      if (currentPosition != null && currentAddress != null) {
        double latitude = currentPosition!.latitude;
        double longitude = currentPosition!.longitude;
        if(!isLocalSwitchOn && cityController.text.isEmpty){
          city = currentAddress!.split(",")[0];
        }
        if(isLocalSwitchOn && beachSpotController.text.isNotEmpty && currentGuarita != null){
          latitude = currentGuarita!.latitude ?? 0.0;
          longitude = currentGuarita!.longitude ?? 0.0;
        }
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
          _queueRegister(registerData, 'technical', _image, _image2, context);
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
  }

  Future<SimpleRegisterRequest?> sendSimpleRegisterToApi(
      String name, String hour, bool witnessed,
      double latitude, double longitude, String city, String beachSpot, String referencePoint) async {
    User user = FirebaseAuth.instance.currentUser!;
    try{
      if(_image == null){
        _image = _image2;
        _image2 = null;
      }
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
        city: city,
        beachSpot: beachSpot,
        referencePoint: referencePoint,
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
      if(_image == null){
        _image = _image2;
        _image2 = null;
      }
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

  void _queueRegister(Map<String, dynamic> registerData, String registerType, File? image, File? image2, BuildContext context) {
      final newRegister = LocalRegister(
        registerType: registerType,
        data: registerData,
        status: RegisterStatus.pending,
        registerImagePath: image?.path,
        registerImagePath2: image2?.path
      );
      _registerBox.add(newRegister);
      _showSuccessMessage(context, 'Registro salvo localmente. Será enviado quando a internet voltar.');
      Navigator.pushNamedAndRemoveUntil(context, BasePage.routeName, (Route<dynamic> route) => false, arguments: 0);
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
                  register.data['city'],
                  register.data['beachSpot'],
                  register.data['referencePoint'],
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

  void initConnectivityListener(BuildContext context){
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