import 'package:tcc_ceclimar/models/animal_response.dart';
import 'package:tcc_ceclimar/models/register_response.dart';

List<RegisterResponse> generatePlaceholderRegisters(int count) {
  return List.filled(
    count,
    RegisterResponse(
      date: DateTime.now(),
      registerImageUrl: '',
      animal: AnimalResponse(
        id: 1,
        popularName: 'Carregando...',
        scientificName: 'Carregando...',
        genus: 'Carregando...',
        species: 'Carregando...',
        family: 'Carregando...',
        order: 'Carregando...',
        classe: 'Carregando...',
        quantity: 0,
        imageUrl: '',
        badgeUrl: '',
      ),
      city: 'Carregando...',
      status: 'Carregando...',
      registerNumber: '',
      state: true,
      userId: '',
      authorName: '',
      beachSpot: '',
      longitude: '',
      latitude: '',
    ),
  );
}