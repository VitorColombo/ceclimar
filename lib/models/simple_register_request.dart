class SimpleRegisterRequest {
  final String name;
  final String? hour;
  final bool witnessed;
  final String latitude;
  final String longitude;
  final String? image;
  final String? image2;

  SimpleRegisterRequest({
    required this.name,
    required this.witnessed,
    required this.latitude,
    required this.longitude,
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
      image2 = json['image2'];
}