class TechnicalRegisterRequest {
  final String userId;
  final String registerNumber;
  final String authorName;
  final String popularName;
  final String species;
  final String city;
  final String beachSpot;
  final bool witnessed;
  final String? hour;
  final String? obs;
  final String? classe;
  final String? order;
  final String? family;
  final String? genu;
  final String latitude;
  final String longitude;
  final String? registerImageUrl;
  final String? registerImageUrl2;
  final DateTime date;
  final String? status;

  TechnicalRegisterRequest({
    required this.userId,
    required this.registerNumber,
    required this.authorName,
    required this.popularName,
    this.hour,
    required this.witnessed,
    required this.species,
    required this.city,
    required this.beachSpot,
    required this.obs,
    required this.classe,
    required this.order,
    required this.family,
    required this.genu,
    required this.latitude,
    required this.longitude,
    required this.date,
    this.registerImageUrl,
    this.registerImageUrl2,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'registerNumber': registerNumber,
      'authorName': authorName,
      'popularName': popularName,
      'hour': hour,
      'witnessed': witnessed,
      'species': species,
      'city': city,
      'beachSpot': beachSpot,
      'obs': obs,
      'classe': classe,
      'order': order,
      'family': family,
      'genu': genu,
      'latitude': latitude,
      'longitude': longitude,
      'registerImageUrl': registerImageUrl,
      'registerImageUrl2': registerImageUrl2,
      'date': date,
      'status': status,
    };
  }

  TechnicalRegisterRequest.fromJson(Map<String, dynamic> json)
    : 
      userId = json['userId'],
      registerNumber = json['registerNumber'],
      authorName = json['authorName'],
      popularName = json['popularName'],
      hour = json['hour'],
      witnessed = json['witnessed'],
      species = json['species'],
      city = json['city'],
      beachSpot = json['beachSpot'],
      obs = json['obs'],
      classe = json['classe'],
      order = json['order'],
      family = json['family'],
      genu = json['genu'],
      latitude = json['latitude'],
      longitude = json['longitude'],
      date = json['date'],
      registerImageUrl = json['registerImageUrl'],
      registerImageUrl2 = json['registerImageUrl2'],
      status = json['status'];
}