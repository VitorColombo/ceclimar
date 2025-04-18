import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc_ceclimar/models/animal_response.dart';

class RegisterResponse {
  final String registerNumber;
  final String userId;
  final String authorName;
  final String city;
  final DateTime date;
  final String? hour;
  final bool state;
  final String beachSpot;
  final String? referencePoint;
  final int? sampleState;
  final String latitude;
  final String longitude;
  final String? specialistReturn;
  final String? obs;
  final String registerImageUrl;
  final String? registerImageUrl2;
  final String status;
  final AnimalResponse animal;

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
    this.referencePoint,
    this.sampleState,
    required this.latitude,
    required this.longitude,
    this.specialistReturn,
    this.obs,
    required this.animal,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      registerNumber: json['registerNumber'] ?? '',
      userId: json['userId'] ?? '',
      authorName: json['authorName'] ?? '',
      city: json['city'] ?? '',
      date: json['date'] is Timestamp
          ? (json['date'] as Timestamp).toDate()
          : DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      hour: json['hour'],
      state: json['state'] ?? false,
      beachSpot: json['beachSpot'] ?? '',
      referencePoint: json['referencePoint'] ?? '',
      sampleState: json['sampleState'],
      latitude: json['location']?['latitude'] ?? '',
      longitude: json['location']?['longitude'] ?? '',
      specialistReturn: json['specialistReturn'],
      obs: json['obs'],
      registerImageUrl: json['registerImageUrl'] ?? '',
      registerImageUrl2: json['registerImageUrl2'],
      status: json['status'] ?? '',
      animal: AnimalResponse.fromJson(json['animal'] ?? {}), 
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
      'referencePoint': referencePoint,
      'sampleState': sampleState,
      'latitude': latitude,
      'longitude': longitude,
      'specialistReturn': specialistReturn,
      'obs': obs,
      'registerImageUrl': registerImageUrl,
      'registerImageUrl2': registerImageUrl2,
      'status': status,
      'animal': animal.toJson(),
    };
  }

  RegisterResponse copyWith({
    String? registerNumber,
    String? userId,
    String? authorName,
    String? city,
    DateTime? date,
    String? hour,
    bool? state,
    String? beachSpot,
    String? referencePoint,
    int? sampleState,
    String? latitude,
    String? longitude,
    String? specialistReturn,
    String? obs,
    String? registerImageUrl,
    String? registerImageUrl2,
    String? status,
    AnimalResponse? animal,
  }) {
    return RegisterResponse(
      registerNumber: registerNumber ?? this.registerNumber,
      userId: userId ?? this.userId,
      authorName: authorName ?? this.authorName,
      city: city ?? this.city,
      date: date ?? this.date,
      hour: hour ?? this.hour,
      state: state ?? this.state,
      beachSpot: beachSpot ?? this.beachSpot,
      referencePoint: referencePoint ?? this.referencePoint,
      sampleState: sampleState ?? this.sampleState,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      specialistReturn: specialistReturn ?? this.specialistReturn,
      obs: obs ?? this.obs,
      registerImageUrl: registerImageUrl ?? this.registerImageUrl,
      registerImageUrl2: registerImageUrl2 ?? this.registerImageUrl2,
      status: status ?? this.status,
      animal: animal ?? this.animal,
    );
  }
}