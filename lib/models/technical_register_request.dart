class TechnicalRegisterRequest {
  final String userId;
  final String registerNumber;
  final String authorName;
  final Map<String, dynamic> animal;
  final String? hour;
  final bool witnessed;
  final Map<String, dynamic> location;
  final String city;
  final String beachSpot;
  final String? obs;
  final String registerImageUrl;
  final String? registerImageUrl2;
  final DateTime date;
  final String? status;

  TechnicalRegisterRequest({
    required this.userId,
    required this.registerNumber,
    required this.authorName,
    required this.animal,
    this.hour,
    required this.witnessed,
    required this.city,
    required this.beachSpot,
    this.obs,
    required this.location,
    required this.registerImageUrl,
    this.registerImageUrl2,
    required this.date,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'registerNumber': registerNumber,
      'authorName': authorName,
      'animal': animal,
      'hour': hour,
      'witnessed': witnessed,
      'city': city,
      'beachSpot': beachSpot,
      'obs': obs,
      'location': location,
      'registerImageUrl': registerImageUrl,
      'registerImageUrl2': registerImageUrl2,
      'date': date.toIso8601String(),
      'status': status,
    };
  }

  TechnicalRegisterRequest.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        registerNumber = json['registerNumber'],
        authorName = json['authorName'],
        animal = json['animal'],
        hour = json['hour'],
        witnessed = json['witnessed'],
        city = json['city'],
        beachSpot = json['beachSpot'],
        obs = json['obs'],
        location = json['location'],
        registerImageUrl = json['registerImageUrl'],
        registerImageUrl2 = json['registerImageUrl2'],
        date = DateTime.parse(json['date']),
        status = json['status'];
}