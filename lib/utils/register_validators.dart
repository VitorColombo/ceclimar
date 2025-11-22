import 'package:tcc_ceclimar/utils/register_errors.dart';

String? validateName(String? value) {
  if (value == null || value.isEmpty) return RegisterError.requiredField.message;
  final RegExp regex = RegExp(r'^[\p{L}\s\-]+$', unicode: true);
  if (!regex.hasMatch(value)) return RegisterError.invalidCharacter.message;
  if (value.length < 3) return '${RegisterError.minimumCharacter.message} 3';
  if (value.length > 40) return '${RegisterError.maximumCharacter.message} 40';
  return null;
}

String? validateHour(String? value) {
  if (value == null || value.isEmpty) return RegisterError.requiredField.message;
  return null;
}

String? validateCitySwitch(String? value) {
  if (value == null || value.isEmpty) return null;
  final RegExp regex = RegExp(r'^[\p{L}\s\-]+$', unicode: true);
  if (value.length < 3) return '${RegisterError.minimumCharacter.message} 3';
  if (value.length > 50) return '${RegisterError.maximumCharacter.message} 50';
  if (!regex.hasMatch(value)) return RegisterError.invalidCharacter.message;
  return null;
}

String? validateBeachSpotSwitch(String value) {
  if (value.isEmpty) return null;
  final RegExp regex = RegExp(r'^[\p{L}\s0-9]+$', unicode: true);
  if (value.length > 10) return '${RegisterError.maximumCharacter.message} 10';
  if (!regex.hasMatch(value)) return RegisterError.invalidCharacter.message;
  return null;
}

String? validateReferencePoint(String value) {
  if (value.isEmpty) return null;
  if (value.length < 5) return '${RegisterError.minimumCharacter.message} 5';
  if (value.length > 50) return '${RegisterError.maximumCharacter.message} 50';
  return null;
}

String? validateSpecies(String value) {
  final RegExp regex = RegExp(r'^[\p{L}\s]+$', unicode: true);
  if (value.isNotEmpty) {
    if (value.length < 5) return '${RegisterError.minimumCharacter.message} 5';
    if (!regex.hasMatch(value)) return RegisterError.invalidCharacter.message;
  }
  return null;
}

String? validateGenu(String value) {
  final RegExp regex = RegExp(r'^[\p{L}\s]+$', unicode: true);
  if (value.isNotEmpty) {
    if (value.length < 3) return '${RegisterError.minimumCharacter.message} 3';
    if (!regex.hasMatch(value)) return RegisterError.invalidCharacter.message;
  }
  return null;
}

String? validateFamily(String value) {
  final RegExp regex = RegExp(r'^[\p{L}\s]+$', unicode: true);
  if (value.isNotEmpty) {
    if (value.length < 3) return '${RegisterError.minimumCharacter.message} 3';
    if (!regex.hasMatch(value)) return RegisterError.invalidCharacter.message;
  }
  return null;
}

String? validateOrder(String value) {
  final RegExp regex = RegExp(r'^[\p{L}\s]+$', unicode: true);
  if (value.isNotEmpty) {
    if (value.length < 3) return '${RegisterError.minimumCharacter.message} 3';
    if (!regex.hasMatch(value)) return RegisterError.invalidCharacter.message;
  }
  return null;
}

String? validateObs(String value) {
  if (value.isNotEmpty && value.length < 5) {
    return '${RegisterError.minimumCharacter.message} 5';
  }
  return null;
}

String? validateLocationSwitch({
  required String city,
  required String beachSpot,
  required String referencePoint,
  required bool isSwitchOn,
}) {
  if (!isSwitchOn) return null;

  final allEmpty = city.isEmpty && beachSpot.isEmpty && referencePoint.isEmpty;
  if (allEmpty) return RegisterError.switchError.message;

  final cityError = validateCitySwitch(city);
  if (cityError != null) return cityError;

  final beachSpotError = validateBeachSpotSwitch(beachSpot);
  if (beachSpotError != null) return beachSpotError;

  final refPointError = validateReferencePoint(referencePoint);
  if (refPointError != null) return refPointError;

  return null;
}

String? validateImages({required bool hasImage1, required bool hasImage2}) {
  if (!hasImage1 && !hasImage2) {
    return RegisterError.imageError.message;
  }
  return null;
}