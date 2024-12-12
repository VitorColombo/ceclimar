class UpdateRegisterRequest {
  final String popularName;
  final String species;
  final String classe;
  final String order;
  final String family;
  final String gender;
  final int sampleState;
  final String? specialistReturn;
  final String status;

  UpdateRegisterRequest({
    required this.popularName,
    required this.species,
    required this.classe,
    required this.order,
    required this.family,
    required this.gender,
    required this.sampleState,
    required this.specialistReturn,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'popularName': popularName,
      'species': species,
      'classe': classe,
      'order': order,
      'family': family,
      'gender': gender,
      'status': status,
      'sampleState': sampleState,
      'specialistReturn': specialistReturn,
    };
  }

  UpdateRegisterRequest.fromJson(Map<String, dynamic> json)
    : popularName = json['popularName'],
      species = json['species'],
      classe = json['classe'],
      order = json['order'],
      family = json['family'],
      gender = json['gender'],
      status = json['status'],
      sampleState = json['sampleState'],
      specialistReturn = json['specialistReturn'];
}