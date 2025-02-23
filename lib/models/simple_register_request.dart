class SimpleRegisterRequest {
  final String userId;
  final String registerNumber;
  final String authorName;
  final Map<String, dynamic> animal;
  final String? hour;
  final bool witnessed;
  final Map<String, dynamic> location;
  final String registerImageUrl;
  final String? registerImageUrl2;
  final DateTime date;
  final String status;
  final String city;
  final String beachSpot;

  SimpleRegisterRequest({
    required this.userId,
    required this.registerNumber,
    required this.authorName,
    required this.animal,
    required this.witnessed,
    required this.location,
    required this.date,
    required this.status,
    this.hour,
    required this.registerImageUrl,
    this.registerImageUrl2,
    required this.city,
    required this.beachSpot
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'registerNumber': registerNumber,
      'authorName': authorName,
      'animal': animal,
      'hour': hour,
      'witnessed': witnessed,
      'location': location,
      'registerImageUrl': registerImageUrl,
      'registerImageUrl2': registerImageUrl2,
      'date': date.toIso8601String(),
      'status': status,
      'city': city,
      'beachSpot': beachSpot
    };
  }

  SimpleRegisterRequest.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        registerNumber = json['registerNumber'],
        authorName = json['authorName'],
        animal = json['animal'],
        hour = json['hour'],
        witnessed = json['witnessed'],
        location = json['location'],
        registerImageUrl = json['registerImageUrl'],
        registerImageUrl2 = json['registerImageUrl2'],
        date = DateTime.parse(json['date']),
        status = json['status'],
        city = json['city'], 
        beachSpot = json['beachSpot'];
}