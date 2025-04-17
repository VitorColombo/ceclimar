import 'package:flutter/material.dart';

class BadgeItem extends StatelessWidget {
  final String classe;
  final Image image;
  
  BadgeItem({super.key, required this.classe, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 110,
                height: 110,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: image,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}