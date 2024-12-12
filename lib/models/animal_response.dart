class AnimalResponse {
  final String popularName;
  final String? species;
  final String? family;
  final String? gender;
  final String? order;
  final String? classe;
  final String imageUrl;
  final String badgeUrl;

  AnimalResponse({
    required this.popularName,
    required this.imageUrl,
    required this.badgeUrl,
    this.species,
    this.family,
    this.gender,
    this.order,
    this.classe,
  });

  factory AnimalResponse.fromJson(Map<String, dynamic> json) {
    return AnimalResponse(
      popularName: json['popularName'] ?? '',
      imageUrl: json['imageUrl'] ?? '', 
      badgeUrl: json['badgeUrl'] ?? '', 
      species: json['species'],
      family: json['family'],
      gender: json['gender'],
      order: json['order'],
      classe: json['classe'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'popularName': popularName,
      'imageUrl': imageUrl,
      'badgeUrl': badgeUrl,
      'species': species,
      'family': family,
      'gender': gender,
      'order': order,
      'classe': classe,
    };
  }
}
