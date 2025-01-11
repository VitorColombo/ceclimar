import 'package:tcc_ceclimar/models/animal_update_request.dart';

class UpdateRegisterRequest {
  final AnimalUpdateRequest animal;
  final int sampleState;
  final String? specialistReturn;
  final String status;

  UpdateRegisterRequest({
    required this.animal,
    required this.sampleState,
    this.specialistReturn,
    required this.status,
  });


  Map<String, dynamic> toJson() {
    return {
      'animal': animal.toJson(),
      'sampleState': sampleState,
      'specialistReturn': specialistReturn,
      'status': status,
    };
  }

  factory UpdateRegisterRequest.fromJson(Map<String, dynamic> json) {
    return UpdateRegisterRequest(
      animal: AnimalUpdateRequest.fromJson(json['animal'] ?? {}),
      sampleState: json['sampleState'] ?? 0,
      specialistReturn: json['specialistReturn'],
      status: json['status'] ?? '',
    );
  }
}