import 'package:flutter/material.dart';
import 'circular_image_widget.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Transform.translate(offset: const Offset(0, -10),
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/header.png',
                fit: BoxFit.cover
              ),
            )
        ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 130),
              CircularImageWidget(
                imageProvider: const AssetImage('assets/images/logo.png'),
                width: 148,
                heigth: 170,
              ),
            ],
          ),
        ],
      ),
    );
  }
}