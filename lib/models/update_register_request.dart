import 'package:tcc_ceclimar/models/animal_update_request.dart';

class UpdateRegisterRequest {
  final AnimalUpdateRequest animal;
  final int sampleState;
  final String? specialistReturn;
  final String status;
  final Map<String, dynamic>? location;
  final String? city;
  final String? beachSpot;

  UpdateRegisterRequest({
    required this.animal,
    required this.sampleState,
    this.specialistReturn,
    required this.status,
    this.location,
    this.city,
    this.beachSpot
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['animal'] = animal.toJson();
    data['sampleState'] = sampleState;
    data['status'] = status;

    if (specialistReturn != null && specialistReturn!.isNotEmpty) {
      data['specialistReturn'] = specialistReturn;
    }

    if (location != null && 
        location!.isNotEmpty &&
        location!['latitude'] != "null" &&
        location!['longitude'] != "null"
       ) {
      data['location'] = location;
    }

    if (city != null && city!.isNotEmpty) {
      data['city'] = city;
    }

    if (beachSpot != null && beachSpot!.isNotEmpty) {
      data['beachSpot'] = beachSpot;
    }

    return data;
  }

  factory UpdateRegisterRequest.fromJson(Map<String, dynamic> json) {
    return UpdateRegisterRequest(
      animal: AnimalUpdateRequest.fromJson(json['animal'] ?? {}),
      sampleState: json['sampleState'] ?? 0,
      specialistReturn: json['specialistReturn'],
      status: json['status'] ?? '',
      location: json['location'],
      city: json['city'],
      beachSpot: json['beachSpot']
    );
  }
}