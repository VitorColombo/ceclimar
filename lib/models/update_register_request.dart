class UpdateRegisterRequest {
  final String name;
  final String species;
  final String obs;
  final String classe;
  final String order;
  final String family;
  final String gender;
  final String animalStatus;

  UpdateRegisterRequest({
    required this.name,
    required this.species,
    required this.obs,
    required this.classe,
    required this.order,
    required this.family,
    required this.gender,
    required this.animalStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'species': species,
      'classe': classe,
      'order': order,
      'family': family,
      'gender': gender,
      'animalStatus': animalStatus,
      'obs': obs,
    };
  }

  UpdateRegisterRequest.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      species = json['species'],
      classe = json['classe'],
      order = json['order'],
      family = json['family'],
      gender = json['gender'],
      animalStatus = json['animalStatus'],
      obs = json['obs'];
}