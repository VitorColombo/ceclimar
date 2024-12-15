class UpdateRegisterRequest {
  final String popularName;
  final String species;
  final String classe;
  final String order;
  final String family;
  final String genu;
  final int sampleState;
  final String? specialistReturn;
  final String status;

  UpdateRegisterRequest({
    required this.popularName,
    required this.species,
    required this.classe,
    required this.order,
    required this.family,
    required this.genu,
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
      'genu': genu,
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
      genu = json['genu'],
      status = json['status'],
      sampleState = json['sampleState'],
      specialistReturn = json['specialistReturn'];
}