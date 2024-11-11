import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/models/animal_response.dart';
import 'package:tcc_ceclimar/models/register_response.dart';

class MyProfileController {
  
  List<RegisterResponse> getRegisters(){ //todo remover mocks
      List<RegisterResponse> registers = [
        RegisterResponse(
          uid: '1',
          date: '20/10/2020',
          city: 'Xangri-lá',
          state: true,
          authorName: 'John Doe',
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Validado",
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          ),
          sampleState: 4,
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Pinguim-de-magalhaes',
            image: Image.asset('assets/images/logo.png'),
            badge: Image.asset('assets/images/logo.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
        RegisterResponse(
          uid: '2',
          date: '25/10/2020',
          city: 'Xangri-lá',
          state: false,
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Validado",
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          ),
          sampleState: 1,
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Foca',
            image: Image.asset('assets/images/logo.png'),
            badge: Image.asset('assets/images/logo.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
        RegisterResponse(
          uid: '3',
          date: '30/10/2020',
          city: 'Xangri-lá',
          state: true,
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Enviado",
          registerImage: Image.asset(
            'assets/images/pinguim.png',
            fit: BoxFit.cover
          ),
          sampleState: 3,
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Pinguim',
            image: Image.asset('assets/images/pinguim.png'),
            badge: Image.asset('assets/images/logo.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
        RegisterResponse(
          uid: '4',
          date: '20/10/2020',
          city: 'Xangri-lá',
          state: true,
          authorName: 'John Doe',
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Validado",
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          ),
          sampleState: 2,
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Golfinho',
            image: Image.asset('assets/images/logo.png'), //todo imagem de fauna local
            badge: Image.asset('assets/images/logo.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
        RegisterResponse(
          uid: '5',
          date: '25/10/2020',
          city: 'Xangri-lá',
          state: false,
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Validado",
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          ),
          sampleState: 5,
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Coruja-buraqueira',
            image: Image.asset('assets/images/logo.png'),
            badge: Image.asset('assets/images/logo.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
        RegisterResponse(
          uid: '6',
          date: '30/10/2020',
          city: 'Xangri-lá',
          state: true,
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Enviado",
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          ),
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Albatroz',
            image: Image.asset('assets/images/logo.png'),
            badge: Image.asset('assets/images/logo.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
        RegisterResponse(
          uid: '7',
          date: '20/10/2020',
          city: 'Xangri-lá',
          state: true,
          authorName: 'John Doe',
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Validado",
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          ),
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Lobo-marinho',
            image: Image.asset('assets/images/logo.png'),
            badge: Image.asset('assets/images/logo.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
        RegisterResponse(
          uid: '8',
          date: '25/10/2020',
          city: 'Xangri-lá',
          state: false,
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Enviado",
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          ),
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Quero-quero',
            image: Image.asset('assets/images/logo.png'),
            badge: Image.asset('assets/images/logo.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
        RegisterResponse(
          uid: '9',
          date: '30/10/2020',
          city: 'Xangri-lá',
          state: true,
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Validado",
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          ),
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Tuim-de-asa-branca',
            image: Image.asset('assets/images/logo.png'),
            badge: Image.asset('assets/images/logo.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
        RegisterResponse(
          uid: '10',
          date: '20/10/2020',
          city: 'Xangri-lá',
          state: true,
          authorName: 'John Doe',
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Enviado",
          registerImage: Image.asset(
            'assets/images/tartaruga.png',
            fit: BoxFit.cover
          ),
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Tartaruga verde',
            image: Image.asset('assets/images/tartaruga.png'),
            badge: Image.asset('assets/images/logo.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
        RegisterResponse(
          uid: '11',
          date: '25/10/2020',
          city: 'Xangri-lá',
          state: false,
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Validado",
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          ),
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Pinguim-de-magalhaes',
            image: Image.asset('assets/images/logo.png'),
            badge: Image.asset('assets/images/logo.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
        RegisterResponse(
          uid: '12',
          date: '30/10/2020',
          city: 'Xangri-lá',
          state: true,
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Validado",
          registerImage: Image.asset(
            'assets/images/tartaruga.png',
            fit: BoxFit.cover
          ),
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Lobo-marinho',
            image: Image.asset('assets/images/tartaruga.png'),
            badge: Image.asset('assets/images/loboMarinhoBadge.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
      ];

      return registers;
  }
}