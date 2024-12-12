class SimpleRegisterRequest {
  final String userId;
  final String registerNumber;
  final String authorName;
  final String popularName;
  final String? hour;
  final bool witnessed;
  final String latitude;
  final String longitude;
  final String registerImageUrl;
  final String? registerImageUrl2;
  final DateTime date;
  final String status;

  SimpleRegisterRequest({
    required this.userId,
    required this.registerNumber,
    required this.authorName,
    required this.popularName,
    required this.witnessed,
    required this.latitude,
    required this.longitude,
    required this.date,
    required this.status,
    this.hour,
    required this.registerImageUrl,
    this.registerImageUrl2,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'registerNumber': registerNumber,
      'authorName': authorName,
      'popularName': popularName,
      'hour': hour,
      'witnessed': witnessed,
      'latitude': latitude,
      'longitude': longitude,
      'date': date,
      'status': status,
      'registerImageUrl': registerImageUrl,
      'registerImageUrl2': registerImageUrl2,
    };
  }

  SimpleRegisterRequest.fromJson(Map<String, dynamic> json)
    : 
      userId = json['userId'],
      registerNumber = json['registerNumber'],
      authorName = json['authorName'],
      popularName = json['popularName'],
      hour = json['hour'],
      witnessed = json['witnessed'],
      registerImageUrl = json['registerImageUrl'],
      latitude = json['latitude'],
      longitude = json['longitude'],
      date = json['date'],
      status = json['status'],
      registerImageUrl2 = json['registerImageUrl2'];
}