import 'package:flutter/material.dart';

class LogoCircularImageWidget extends StatelessWidget {
  final double width;
  final double heigth;

  const LogoCircularImageWidget({
    super.key, 
    required this.width,
    required this.heigth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: heigth,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(width: 4, color: Colors.white),
          color: Colors.white,
          shape: BoxShape.circle, 
          image: DecorationImage(
            image: AssetImage('assets/images/logo.png'),
            fit: BoxFit.cover
          ),          
        )
    );
  } //build
}// class