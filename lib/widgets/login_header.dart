import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/widgets/page_header.dart';
import 'circular_image_widget.dart';

class LoginHeaderWidget extends StatelessWidget {
  final Future<ImageProvider?> imageFuture;
  final PageHeader? pageHeader;

  const LoginHeaderWidget({
    super.key,
    required this.imageFuture,
    this.pageHeader,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          top: -380,
          left: -50,
          right: -50,
          bottom: 20,
          child: Image.asset(
            'assets/images/header.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        Container(
          height: 250,
          child: Align(
            alignment: Alignment.topLeft,
            child: pageHeader,
          ),
        ),
        Transform.translate(
          offset: const Offset(0, 15),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FutureBuilder<ImageProvider?>(
              future: imageFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 148,
                    width: 170,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      color: Colors.white,
                      shape: BoxShape.circle, 
                    ),
                    child: const Center(child: CircularProgressIndicator())
                );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return CircularImageWidget(
                    imageProvider: snapshot.data!,
                    width: 148,
                    heigth: 170,
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}