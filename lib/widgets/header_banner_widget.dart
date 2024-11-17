import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/widgets/page_header.dart';
import 'circular_image_widget.dart';

class HeaderBannerWidget extends StatelessWidget {
  final ImageProvider? image;
  final PageHeader? pageHeader;
  const HeaderBannerWidget({
    super.key,
    required this.image,
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
            child: pageHeader
          ), 
        ),
        Transform.translate(
          offset: const Offset(0, 15),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: CircularImageWidget(
              imageProvider: image!,
              width: 148,
              heigth: 170,
            ),
          ),
        ),
      ],
    );
  }
}