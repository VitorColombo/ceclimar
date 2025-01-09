import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tcc_ceclimar/widgets/page_header.dart';
import 'circular_image_widget.dart';

class LoginHeaderWidget extends StatelessWidget {
  final Future<ImageProvider?> imageFuture;
  final PageHeader? pageHeader;
  final ImageProvider? defaultImage;

  const LoginHeaderWidget({
    super.key,
    required this.imageFuture,
    this.pageHeader,
    this.defaultImage,
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
        SizedBox(
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
                  return Skeletonizer(
                    enabled: true,
                    child: Container(
                      height: 148,
                      width: 170,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Container(
                    height: 148,
                    width: 170,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.error, color: Colors.red),
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data != null) {
                    return CircularImageWidget(
                      imageProvider: snapshot.data!,
                      width: 148,
                      heigth: 170,
                  );
                } else {
                  return Container(
                      height: 148,
                      width: 170,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: defaultImage != null ? 
                      CircularImageWidget(imageProvider: defaultImage!, width: 148, heigth: 170) :
                       Container(),
                    );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}