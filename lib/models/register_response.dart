import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterResponse {
  final String uid;
  final String? authorName;
  final String city;
  final String date;
  final bool state;
  final String popularName;
  final String? species;
  final String? beachSpot;
  final String? sampleState;
  final GeoPoint? location;
  final String? scientistReturn;
  final String? observation;
  final String? family;
  final String? gender;
  final String? order;
  final Image registerImage;

  RegisterResponse({
    required this.uid,
    required this.date,
    required this.popularName,
    required this.city,
    required this.state,
    required this.registerImage,
    this.authorName,
    this.species,
    this.beachSpot,
    this.sampleState,
    this.location,
    this.scientistReturn,
    this.observation,
    this.family,
    this.gender,
    this.order,
  });
}