import 'dart:io';

import 'package:flutter/material.dart';

class RegisterCircularImageWidget extends StatelessWidget {
  final File? imageProvider;
  final double width;
  final double heigth;
  final Function()? onTap;

  const RegisterCircularImageWidget({
    super.key, 
    required this.imageProvider,
    required this.width,
    required this.heigth,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: heigth,
        width: width,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 191, 219, 224),
          shape: BoxShape.circle,
          image: imageProvider != null
              ? DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(imageProvider!),
                )
              : null,
        ),
        child: imageProvider == null
            ? Icon(
                Icons.add_a_photo,
                size: width / 2.5,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}