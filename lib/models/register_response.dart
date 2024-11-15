import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/models/animal_response.dart';

class RegisterResponse {
  final String uid;
  final String authorName;
  final String city;
  final String date;
  final String? hour;
  final bool state;
  final String beachSpot;
  final int? sampleState;
  final GeoPoint location;
  final String? specialistReturn;
  final String? observation;
  final Image registerImage;
  final Image? registerImage2;
  final AnimalResponse animal;
  final String status;

  RegisterResponse({
    required this.uid,
    required this.date,
    required this.city,
    required this.state,
    required this.registerImage,
    this.registerImage2,
    required this.animal,
    required this.status,
    this.hour,
    required this.authorName,
    required this.beachSpot,
    this.sampleState,
    required this.location,
    this.specialistReturn,
    this.observation,
  });
}