class AnimalUpdateRequest {
  final String? popularName;
  final String? species;
  final String? classe;
  final String? order;
  final String? family;
  final String? genus;


  AnimalUpdateRequest({
    this.popularName,
    this.species,
    this.classe,
    this.order,
    this.family,
    this.genus,
  });


  Map<String, dynamic> toJson() {
    return {
      'popularName': popularName,
      'species': species,
      'classe': classe,
      'order': order,
      'family': family,
      'genus': genus,
    };
  }

 factory AnimalUpdateRequest.fromJson(Map<String, dynamic> json) {
    return AnimalUpdateRequest(
      popularName: json['popularName'] ?? '',
      species: json['species'] ?? '',
      classe: json['classe'] ?? '',
      order: json['order'] ?? '',
      family: json['family'] ?? '',
      genus: json['genus'] ?? '',
    );
  }
}
