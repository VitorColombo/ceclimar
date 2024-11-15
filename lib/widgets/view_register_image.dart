import 'package:flutter/material.dart';

class ViewRegisterImage extends StatefulWidget {
  final Image imageProvider;

  const ViewRegisterImage({
    super.key,
    required this.imageProvider,
  });

  @override
  State<ViewRegisterImage> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ViewRegisterImage> {
  late Image _currentImage;

  @override
  void initState() {
    super.initState();
    _currentImage = widget.imageProvider;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 30, left: 30, right: 30, top: 5),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      height: 500,
      child: Center(
        child: Column(
          children: [
            Divider(
              color: Colors.grey[400],
              thickness: 2,
              indent: 100,
              endIndent: 100,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: InteractiveViewer(
                  panEnabled: true,
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: _currentImage,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}