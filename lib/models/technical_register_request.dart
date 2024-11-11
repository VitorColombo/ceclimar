class TechnicalRegisterRequest {
  final String name;
  final String species;
  final String city;
  final String beachSpot;
  final bool witnessed;
  final String? hour;
  final String? obs;
  final String? classe;
  final String? order;
  final String? family;
  final String? gender;
  final String latitude;
  final String longitude;
  final String? image;
  final String? image2;

  TechnicalRegisterRequest({
    required this.name,
    this.hour,
    required this.witnessed,
    required this.species,
    required this.city,
    required this.beachSpot,
    required this.obs,
    required this.classe,
    required this.order,
    required this.family,
    required this.gender,
    required this.latitude,
    required this.longitude,
    this.image,
    this.image2,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'hour': hour,
      'witnessed': witnessed,
      'species': species,
      'city': city,
      'beachSpot': beachSpot,
      'obs': obs,
      'classe': classe,
      'order': order,
      'family': family,
      'gender': gender,
      'latitude': latitude,
      'longitude': longitude,
      'image': image,
      'image2': image2,
    };
  }

  TechnicalRegisterRequest.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      hour = json['hour'],
      witnessed = json['witnessed'],
      species = json['species'],
      city = json['city'],
      beachSpot = json['beachSpot'],
      obs = json['obs'],
      classe = json['classe'],
      order = json['order'],
      family = json['family'],
      gender = json['gender'],
      latitude = json['latitude'],
      longitude = json['longitude'],
      image = json['image'],
      image2 = json['image2'];
}