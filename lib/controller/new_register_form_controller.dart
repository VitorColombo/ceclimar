import 'dart:async';
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
import 'package:tcc_ceclimar/utils/location_utils.dart';
import 'package:tcc_ceclimar/utils/register_errors.dart';
import 'package:tcc_ceclimar/utils/register_status.dart';
import 'package:tcc_ceclimar/utils/register_type_enum.dart';
import 'package:tcc_ceclimar/utils/register_validators.dart';

class NewRegisterFormController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
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
  DateTime? dateOriginal;
  Position? currentPosition;
  GuaritaData? currentGuarita;
  final String newRegisterEndpoint = '';
  bool isHourSwitchOn = false;
  bool isLocalSwitchOn = false;
  final Box<LocalRegister> _registerBox = Hive.box<LocalRegister>('registers');
  
  String? nameError;
  String? hourError;
  String? dateError;
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
    dateController.dispose();
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
    nameError = validateName(nameController.text.trim());
    hourError = isHourSwitchOn ? validateHour(hourController.text) : null;
    imageError = validateImages(hasImage1: _image != null, hasImage2: _image2 != null);

    if (isLocalSwitchOn) {
      dateError = validateDate(dateOriginal != null ? dateOriginal.toString() : '');

      cityError = validateCitySwitch(cityController.text.trim());
      beachSpotError = validateBeachSpotSwitch(beachSpotController.text.trim());
      referencePointError = validateReferencePoint(referencePointController.text.trim());

      final hasAnyLocationField = cityController.text.trim().isNotEmpty ||
                                  beachSpotController.text.trim().isNotEmpty ||
                                  referencePointController.text.trim().isNotEmpty;

      locationSwitchError = hasAnyLocationField ? null : RegisterError.switchError.message;
    } else {
      cityError = null;
      beachSpotError = null;
      referencePointError = null;
      dateError = null;
      locationSwitchError = null;
    }

    return nameError == null &&
          hourError == null &&
          dateError == null &&
          imageError == null &&
          cityError == null &&
          beachSpotError == null &&
          referencePointError == null &&
          locationSwitchError == null;
  }

  bool validateTechnicalForm() {
    nameError = validateName(nameController.text.trim());
    hourError = isHourSwitchOn ? validateHour(hourController.text) : null;
    imageError = validateImages(hasImage1: _image != null, hasImage2: _image2 != null);

    speciesError = validateSpecies(speciesController.text.trim());
    obsError = validateObs(obsController.text.trim());
    familyError = validateFamily(familyController.text.trim());
    genuError = validateGenu(genuController.text.trim());
    orderError = validateOrder(orderController.text.trim());
    classError = validateOrder(classController.text.trim());

    if (isLocalSwitchOn) {
      cityError = validateCitySwitch(cityController.text.trim());
      beachSpotError = validateBeachSpotSwitch(beachSpotController.text.trim());
      referencePointError = validateReferencePoint(referencePointController.text.trim());
      dateError = validateDate(dateOriginal != null ? dateOriginal.toString() : '');

      final allEmpty = cityController.text.trim().isEmpty &&
                      beachSpotController.text.trim().isEmpty &&
                      referencePointController.text.trim().isEmpty;

      locationSwitchError = allEmpty ? RegisterError.switchError.message : null;
    } else {
      cityError = null;
      beachSpotError = null;
      referencePointError = null;
      dateError = null;
      locationSwitchError = null;
    }

    return nameError == null &&
          hourError == null &&
          dateError == null &&
          imageError == null &&
          speciesError == null &&
          obsError == null &&
          familyError == null &&
          genuError == null &&
          orderError == null &&
          classError == null &&
          cityError == null &&
          beachSpotError == null &&
          referencePointError == null &&
          locationSwitchError == null;
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

  //TODO: create a file for this locationService
  Future<void> getAddressFromLatLng(Position position, BuildContext context) async {
    if (position.latitude == 0.0 && position.longitude == 0.0) {
      debugPrint('Coordenadas inválidas: (0.0, 0.0)');
      return;
    }
    
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      debugPrint('Sem conexão com a internet. Não é possível obter o endereço.');
      currentAddress = null;
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Dados de latitude e longitude coletados'),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      currentAddress ='${place.subAdministrativeArea}, ${place.postalCode}';
    } on PlatformException catch (e) {
      debugPrint('Error when getting the address from lat and long $e');
      if (!context.mounted) return;
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
      debugPrint('Erro inesperado ao obter endereço: $e');
    }
  }

  Future<Location> _getCityLatLong(String city) async {
    try {
      List<Location> locations = await locationFromAddress(city);
      return locations.first;
    } catch (e) {
      debugPrint('Erro ao obter coordenadas da cidade: $e');
      throw Exception('Falha ao obter coordenadas para a cidade: $city');
    }
  }

  Future<Position?> resolvePosition(BuildContext context) async {
    final hasPermission = await _handleLocationPermission(context);
    if (!hasPermission) return null;

    try {
      const locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 40),
      );

      final position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      debugPrint("resolvePosition: Posição obtida via GPS: $position");
      return position;
    } catch (e) {
      debugPrint("resolvePosition: Falha ao obter localização: $e");
      if (context.mounted) {
        _showLocationError(context, 'Não foi possível obter sua localização.', Colors.red);
      }
      return null;
    }
  }

  Future<bool> _handleLocationPermission(BuildContext context) async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        _showLocationError(context, 'Habilite o serviço de localização do dispositivo.', Colors.grey);
      }
      return false;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (context.mounted) {
          _showLocationError(context, 'As permissões de localização foram negadas.', Colors.red);
        }
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (context.mounted) {
        _showLocationError(
          context,
          'Permissões negadas permanentemente. Altere nas configurações do dispositivo',
          Colors.red,
        );
      }
      await Geolocator.openAppSettings();
      return false;
    }

    return true;
  }

  void _showLocationError(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(message, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Future<bool> _waitForLocationService({int attempts = 10, Duration interval = const Duration(seconds: 5)}) async {
    for (var i = 0; i < attempts; i++) {
      final enabled = await Geolocator.isLocationServiceEnabled();
      debugPrint('[waitForLocationService] Tentativa ${i + 1}: $enabled');
      if (enabled) return true;
      await Future.delayed(interval);
    }
    return false;
  }

  Future<Map<String, dynamic>> _buildRegisterData(BuildContext context, Position position, RegisterType type) async {
    final locationUtils = LocationUtils();
    final name = nameController.text.trim();
    final hour = hourController.text.trim();
    final date = dateOriginal ?? DateTime.now();
    final witnessed = isHourSwitchOn;
    final referencePoint = referencePointController.text.trim();
    String? city = cityController.text.trim();
    String? beachSpot = beachSpotController.text.trim();

    // Campos técnicos
    final species = speciesController.text.trim();
    final obs = obsController.text.trim();
    final family = familyController.text.trim();
    final genu = genuController.text.trim();
    final order = orderController.text.trim();
    final classe = classController.text.trim();

    double latitude = position.latitude;
    double longitude = position.longitude;

    try {
      await getAddressFromLatLng(position, context);
    } catch (e) {
      debugPrint('Erro ao obter endereço: $e');
      currentAddress = null;
    }

    if (currentPosition != null) {
      latitude = currentPosition!.latitude;
      longitude = currentPosition!.longitude;
    }

    if (!isLocalSwitchOn && city.isEmpty && beachSpot.isEmpty && currentAddress != null) {
      city = currentAddress!.split(",").first.trim();
    }

    if (isLocalSwitchOn) {
      if (beachSpot.isNotEmpty && currentGuarita != null) {
        latitude = currentGuarita!.latitude ?? 0.0;
        longitude = currentGuarita!.longitude ?? 0.0;
        final randomized = locationUtils.getRandomPositionInRadius(latitude, longitude, 50);
        latitude = randomized.latitude;
        longitude = randomized.longitude;
      } else if (city.isNotEmpty && beachSpot.isEmpty) {
        try {
          final loc = await _getCityLatLong(city);
          latitude = loc.latitude;
          longitude = loc.longitude;
        } catch (e) {
          debugPrint('Erro ao buscar coordenadas da cidade: $e');
        }
      } else if (city.isEmpty && beachSpot.isEmpty) {
        latitude = 0.0;
        longitude = 0.0;
      }
    }

      final baseData = {
        "name": name,
        "hour": hour,
        "date": date,
        "witnessed": witnessed,
        "latitude": latitude,
        "longitude": longitude,
        "city": city.isNotEmpty ? city : "",
        "beachSpot": beachSpot.isNotEmpty ? beachSpot : "",
        "referencePoint": referencePoint,
      };

      if (type == RegisterType.technical) {
        return {
          ...baseData,
          "species": species,
          "obs": obs,
          "family": family,
          "genu": genu,
          "order": order,
          "classe": classe,
        };
      } else {
        return baseData;
      }
    

    throw Exception('Invalid RegisterType or missing data (invalid coordinates)');
  }

  Future<void> _handleSubmission(BuildContext context, ConnectivityResult connectivityResult, Map<String, dynamic> data, RegisterType type) async {
    if (connectivityResult == ConnectivityResult.none) {
      _queueRegister(data, type.name, _image, _image2, context);
      return;
    }
    if (type == RegisterType.simple) {
      try {
        final response = await sendSimpleRegisterToApi(
          data['name'],
          data['hour'],
          data['witnessed'],
          data['latitude'],
          data['longitude'],
          data['city'],
          data['beachSpot'],
          data['referencePoint'],
          data['date'],
        );
        if (response != null) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).clearSnackBars();
          _showSuccessMessage(context, 'Registro enviado com sucesso!');
          Navigator.pushNamedAndRemoveUntil(context, BasePage.routeName, (route) => false, arguments: 0);
        } else {
          if (!context.mounted) return;
          _handleError(context, 'Falha ao enviar o registro.');
        }
      } catch (e) {
        if (!context.mounted) return;
        _handleError(context, 'Falha ao enviar registro: $e');
      }
    } else if (type == RegisterType.technical) {
      try{
        final response = await sendTechnicalRegisterToApi(
          data['name'],
          data['hour'],
          data['witnessed'],
          data['species'],
          data['city'],
          data['beachSpot'],
          data['obs'],
          data['family'],
          data['genu'],
          data['order'],
          data['classe'],
          data['latitude'],
          data['longitude'],
          data['referencePoint'],
          data['date'],
        );
        if (response != null) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).clearSnackBars();
          _showSuccessMessage(context, 'Registro enviado com sucesso!');
          Navigator.pushNamedAndRemoveUntil(context, BasePage.routeName, (route) => false, arguments: 0);
        } else {
          if (!context.mounted) return;
          _handleError(context, 'Falha ao enviar o registro.');
        }
      } catch (e) {
      if (!context.mounted) return;
      _handleError(context, 'Falha ao enviar registro: $e');
      }
    }
  }

  Future<void> sendRegister(BuildContext context, RegisterType type) async {
    debugPrint('[sendRegister] Início do processo de registro');
    showStepMessage(context, 'Verificando conexão...');

    final connectivityResult = await Connectivity().checkConnectivity();
    debugPrint('[sendRegister] Conectividade: $connectivityResult');

    if (!context.mounted) {
      debugPrint('[sendRegister] Contexto desmontado, encerrando.');
      return;
    }

    showStepMessage(context, 'Verificando permissões de localização...');
    debugPrint('[sendRegister] Tentando resolver posição...');
    Position? position = await resolvePosition(context);

    if (position == null) {
      debugPrint('[sendRegister] Localização indisponível, solicitando ativação...');
      showStepMessage(context, 'Ativando GPS, aguarde...', color: Colors.orange);

      await Geolocator.openLocationSettings();
      final serviceReady = await _waitForLocationService();
      debugPrint('[sendRegister] Serviço de localização ativado: $serviceReady');

      if (!serviceReady) {
        debugPrint('[sendRegister] Serviço ainda desativado, cancelando.');
        if (context.mounted) {
          _handleError(context, 'Serviço de localização ainda desativado.');
        }
        return;
      }

      showStepMessage(context, 'Tentando novamente obter localização...');
      debugPrint('[sendRegister] Re-tentando resolver posição...');
      position = await resolvePosition(context);
    }

    if (position == null) {
      debugPrint('[sendRegister] Falha ao obter localização após revalidação.');
      if (context.mounted) {
        _handleError(context, 'Não foi possível obter sua localização.');
      }
      return;
    }

    debugPrint('[sendRegister] Localização obtida: (${position.latitude}, ${position.longitude})');
    currentPosition = position;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    showStepMessage(context, 'Construindo dados do registro...');
    debugPrint('[sendRegister] Montando dados...');
    if (!context.mounted) {
      debugPrint('[sendRegister] Contexto desmontado antes de montar dados.');
      return;
    }

    final data = await _buildRegisterData(context, position, type);
    debugPrint('[sendRegister] Dados montados: $data');
    debugPrint('[sendRegister] Enviando registro ao backend...');
    if (!context.mounted) {
      debugPrint('[sendRegister] Contexto desmontado antes do envio.');
      return;
    }

    await _handleSubmission(context, connectivityResult, data, type);
    debugPrint('[sendRegister] Final do processo de envio.');
  }


  void showStepMessage(BuildContext context, String message, {Color color = Colors.blue}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<SimpleRegisterRequest?> sendSimpleRegisterToApi(
      String name, String hour, bool witnessed,
      double latitude, double longitude, String city,
      String beachSpot, String referencePoint, DateTime date) async {
    User user = FirebaseAuth.instance.currentUser!;
    try{
      if(_image == null){
        _image = _image2;
        _image2 = null;
      }
      final int registerId = await getNextRegisterId();
      final String imageUrl = await uploadImageToFirebaseStorage(_image!, registerId, "1");
      final String? imageUrl2 = _image2 != null ? await uploadImageToFirebaseStorage(_image2!, registerId, "2") : null;

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
        date: date,
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
      debugPrint("Error sending simple register $e");
      rethrow;
    }
  }

  //TODO: merge with the sendSimpleRegisterToApi
  Future<TechnicalRegisterRequest?> sendTechnicalRegisterToApi(
      String name, String hour, bool witnessed, String species, String city,
      String beachSpot, String obs, String family, String genu, String order,
      String classe, double latitude, double longitude, String referencePoint, DateTime date) async {     
    User user = FirebaseAuth.instance.currentUser!;
    try{
      if(_image == null){
        _image = _image2;
        _image2 = null;
      }
      final int registerId = await getNextRegisterId();
      final String imageUrl = await uploadImageToFirebaseStorage(_image!, registerId, "1");
      final String? imageUrl2 = _image2 != null ? await uploadImageToFirebaseStorage(_image2!, registerId, "2") : null;

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
          "classe": classe,
        },
        hour: hour,
        witnessed: witnessed,
        location: {
          "latitude": latitude.toString(),
          "longitude": longitude.toString(),
        },
        city: city,
        beachSpot: beachSpot,
        referencePoint: referencePoint,
        obs: obs,
        registerImageUrl: imageUrl,
        registerImageUrl2: imageUrl2,
        date: date,
        status: 'Enviado',
      );
      await addRegisterToFirestore(
        user.uid,
        newRegister.toJson(),
      );
      return newRegister;
    } catch(e){
      debugPrint("Error sending technical register $e");
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

  Future<String> uploadImageToFirebaseStorage(File imageFile, int id, String qtd) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final fileName = "${id}_$qtd";
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
      debugPrint('Erro ao incrementar contador: $e');
      throw Exception('Erro ao obter próximo ID');
    }
  }

  //TODO: create a file for this offline responsibility
  void _queueRegister(Map<String, dynamic> registerData, String registerType, File? image, File? image2, BuildContext context) {
      final newRegister = LocalRegister(
        registerType: registerType,
        data: registerData,
        status: RegisterStatus.pending,
        registerImagePath: image?.path,
        registerImagePath2: image2?.path
      );
      _registerBox.add(newRegister);
      trimRegisterBox();
      ScaffoldMessenger.of(context).clearSnackBars();
      _showSuccessMessage(context, 'Registro salvo localmente. Será enviado quando a internet voltar');
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
      message = 'Falha ao se comunicar com os satélites, tente novamente: $error';
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
                  register.data['date'],
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
                  register.data['referencePoint'],
                  register.data['date'],
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
    debugPrint('------- Hive Data -------');
    for (var register in registerBox.values) {
      debugPrint(register.toJson().toString());
    }
    debugPrint('------- End of Hive Data -------');
  }

  void trimRegisterBox() {
    final allRegisters = _registerBox.values.toList();
    for (var register in allRegisters) {
      debugPrint(register.toJson().toString());
    }    debugPrint('Total de registros: ${allRegisters.length}');
    if (allRegisters.length > 40) {
      allRegisters.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      final latest40 = allRegisters.take(40).toList();
      _registerBox.clear();
      for (var register in latest40) {
        _registerBox.add(register);
        debugPrint('Registro mantido: ${register.toJson()}');
      }
    }
  }
  
  String? validateDate(String trim) {
    if (trim.isEmpty) {
      return RegisterError.requiredField.message;
    }
    return null;
  }
}