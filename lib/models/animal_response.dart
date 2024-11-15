import 'package:flutter/material.dart';

class AnimalResponse {
  final String uid;
  final String popularName;
  final String? species;
  final String? family;
  final String? gender;
  final String? order;
  final String? classe;
  final Image image;
  final Image badge;

  AnimalResponse({
    required this.uid,
    required this.popularName,
    required this.image,
    required this.badge,
    this.species,
    this.family,
    this.gender,
    this.order,
    this.classe,
  });
}