class AnimalResponse {
  final int id;
  final String? popularName;
  final String? scientificName;
  final String? genus;
  final String? species;
  final String? family;
  final String? order;
  final String? classe; 
  final int? quantity;
  final String imageUrl;
  final String badgeUrl;

  AnimalResponse({
    required this.id,
    required this.popularName,
    required this.scientificName,
    required this.genus,
    required this.species,
    required this.family,
    required this.order,
    required this.classe,
    required this.quantity,
    required this.imageUrl,
    required this.badgeUrl,
  });

  factory AnimalResponse.fromJson(Map<String, dynamic> json) {
    return AnimalResponse(
      id: json['id'] ?? 0,
      popularName: json['popularName'] ?? '',
      scientificName: json['scientificName'] ?? '',
      genus: json['genus'] ?? '',
      species: json['species'] ?? '',
      family: json['family'] ?? '',
      order: json['order'] ?? '',
      classe: json['classe'] ?? '',
      quantity: json['quantity'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
      badgeUrl: json['badgeUrl'] ?? '',
    );
  }

  factory AnimalResponse.fromMap(Map<String, dynamic> map) {
    return AnimalResponse(
      id: map['id'],
      popularName: map['popularName']?? '',
      scientificName: map['scientificName']?? '',
      genus: map['genus']?? '',
      species: map['species']?? '',
      family: map['family']?? '',
      order: map['order']?? '',
      classe: map['classe']?? '',
      quantity: map['quantity']?? '',
      imageUrl: map['imageUrl']?? '',
      badgeUrl: map['badgeUrl']?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'popularName': popularName,
      'scientificName': scientificName,
      'genus': genus,
      'species': species,
      'family': family,
      'order': order,
      'class': classe,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'badgeUrl': badgeUrl,
    };
  }
}
