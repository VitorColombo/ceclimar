class SimpleRegisterRequest {
  final String name;
  final String? hour;
  final bool witnessed;
  final String latitude;
  final String longitude;
  final String? image;
  final String? image2;
  final DateTime date;

  SimpleRegisterRequest({
    required this.name,
    required this.witnessed,
    required this.latitude,
    required this.longitude,
    required this.date,
    this.hour,
    this.image,
    this.image2,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'hour': hour,
      'witnessed': witnessed,
      'latitude': latitude,
      'longitude': longitude,
      'date': date,
      'image': image,
      'image2': image2,
    };
  }

  SimpleRegisterRequest.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      hour = json['hour'],
      witnessed = json['witnessed'],
      image = json['image'],
      latitude = json['latitude'],
      longitude = json['longitude'],
      date = json['date'],
      image2 = json['image2'];
}