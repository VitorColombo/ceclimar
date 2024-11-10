import 'dart:typed_data';

class SimpleRegisterRequest {
  final String name;
  final String? hour;
  final bool witnessed;
  final Uint8List image;
  final Uint8List? image2;
  final String latitude;
  final String longitude;

  SimpleRegisterRequest({
    required this.name,
    required this.witnessed,
    required this.image,
    required this.latitude,
    required this.longitude,
    this.hour,
    this.image2,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'hour': hour,
      'witnessed': witnessed,
      'image': image,
      'image2': image2,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  SimpleRegisterRequest.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      hour = json['hour'],
      witnessed = json['witnessed'],
      image = json['image'],
      image2 = json['image2'],
      latitude = json['latitude'],
      longitude = json['longitude'];
}