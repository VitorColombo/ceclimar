import 'dart:io';
import 'package:flutter/material.dart';

class ImageScreen extends StatefulWidget {
  final File? imageProvider;
  final Function() onEditTap;

  const ImageScreen({
    super.key,
    required this.imageProvider,
    required this.onEditTap,
  });

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  late File _currentImage;

  @override
  void initState() {
    super.initState();
    _currentImage = widget.imageProvider!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
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
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: InteractiveViewer(
                  panEnabled: true,
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: Image.file(_currentImage),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onEditTap();
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: const Color.fromARGB(255, 31, 73, 95),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 16,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Inter",
                        ),
                        overlayColor: Colors.white,
                      ),
                      child: const Text(
                      "Alterar imagem",
                      style: TextStyle(color: Colors.white),
                      ),
                    )
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: const Color.fromARGB(255, 31, 73, 95),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 16,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Inter",
                        ),
                        overlayColor: Colors.white,
                      ),
                      child: const Text(
                      "Manter imagem",
                      style: TextStyle(color: Colors.white),
                      ),
                    )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}