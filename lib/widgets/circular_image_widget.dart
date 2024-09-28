import 'package:flutter/material.dart';

class CircularImageWidget extends StatelessWidget {
  final ImageProvider imageProvider;
  final double width;
  final double heigth;

  const CircularImageWidget({
    super.key, 
    required this.imageProvider,
    required this.width,
    required this.heigth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: heigth,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle, 
            image: DecorationImage(
              fit: BoxFit.cover,
              image: imageProvider,
            )
        )
    );
  } //build
}// class