import 'dart:io';
import 'package:flutter/material.dart';
import 'image_screen.dart';

class RegisterCircularImageWidget extends StatefulWidget {
  final File? imageProvider;
  final double width;
  final double heigth;
  final Function() onTap;

  const RegisterCircularImageWidget({
    super.key, 
    required this.imageProvider,
    required this.width,
    required this.heigth,
    required this.onTap,
  });

  @override
  State<RegisterCircularImageWidget> createState() => _RegisterCircularImageWidgetState();
}

class _RegisterCircularImageWidgetState extends State<RegisterCircularImageWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.imageProvider != null) {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return ImageScreen(
                imageProvider: widget.imageProvider,
                onEditTap: widget.onTap,
              );
            },
          );
        } else {
          widget.onTap();
        }
      },      
      child: Container(
        height: widget.heigth,
        width: widget.width,
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Colors.white),
          color: const Color.fromARGB(255, 191, 219, 224),
          shape: BoxShape.circle,
          image: widget.imageProvider != null
              ? DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(widget.imageProvider!),
                )
              : null,
        ),
        child: widget.imageProvider == null
            ? Icon(
                Icons.add_a_photo,
                size: widget.width / 2.5,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}