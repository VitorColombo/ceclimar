import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/models/animal_response.dart';

class RegisterResponse {
  final String uid;
  final String? authorName;
  final String city;
  final String date;
  final bool state;
  final String? beachSpot;
  final String? sampleState;
  final GeoPoint? location;
  final String? scientistReturn;
  final String? observation;
  final Image registerImage;
  final AnimalResponse animal;

  RegisterResponse({
    required this.uid,
    required this.date,
    required this.city,
    required this.state,
    required this.registerImage,
    required this.animal,
    this.authorName,
    this.beachSpot,
    this.sampleState,
    this.location,
    this.scientistReturn,
    this.observation,
  });
}