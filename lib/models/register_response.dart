import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterResponse {
  final String registerNumber;
  final String userId;
  final String authorName;
  final String city;
  final DateTime date;
  final String? hour;
  final bool state;
  final String beachSpot;
  final int? sampleState;
  final String latitude; 
  final String longitude;
  final String? specialistReturn;
  final String? observation;
  final String registerImageUrl;
  final String? registerImageUrl2;
  final String status;
  final String popularName;
  final String? species;
  final String? family;
  final String? gender;
  final String? order;
  final String? classe;

  RegisterResponse({
    required this.registerNumber,
    required this.userId,
    required this.date,
    required this.city,
    required this.state,
    required this.registerImageUrl,
    this.registerImageUrl2,
    required this.status,
    this.hour,
    required this.authorName,
    required this.beachSpot,
    this.sampleState,
    required this.latitude,
    required this.longitude,
    this.specialistReturn,
    this.observation,
    required this.popularName,
    this.species,
    this.family,
    this.gender,
    this.order,
    this.classe,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      registerNumber: json['registerNumber'] ?? '',
      userId: json['userId'] ?? '',
      authorName: json['authorName'] ?? '',
      city: json['city'] ?? '',
      date: (json['date'] as Timestamp).toDate(),
      hour: json['hour'],
      state: json['state'] ?? false,
      beachSpot: json['beachSpot'] ?? '',
      sampleState: json['sampleState'],
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      specialistReturn: json['specialistReturn'],
      observation: json['observation'],
      registerImageUrl: json['registerImageUrl'] ?? '',
      registerImageUrl2: json['registerImageUrl2'],
      status: json['status'] ?? '',
      popularName: json['popularName'] ?? '',
      species: json['species'],
      family: json['family'],
      gender: json['gender'],
      order: json['order'],
      classe: json['classe'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'registerNumber': registerNumber,
      'userId': userId,
      'authorName': authorName,
      'city': city,
      'date': Timestamp.fromDate(date),
      'hour': hour,
      'state': state,
      'beachSpot': beachSpot,
      'sampleState': sampleState,
      'latitude': latitude,
      'longitude': longitude,
      'specialistReturn': specialistReturn,
      'observation': observation,
      'registerImageUrl': registerImageUrl,
      'registerImageUrl2': registerImageUrl2,
      'status': status,
      'popularName': popularName,
      'species': species,
      'family': family,
      'gender': gender,
      'order': order,
      'classe': classe,
    };
  }
}