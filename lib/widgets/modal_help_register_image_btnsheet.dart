import 'package:flutter/material.dart';
import 'modal_help_bottomsheet.dart';

class ModalHelpRegisterImageBottomSheet extends StatelessWidget {
  final String text;
  final String? imagePath;
  final double height;

  const ModalHelpRegisterImageBottomSheet({
    super.key,
    required this.text,
    this.imagePath,
    this.height = 300,
  });

  @override
  Widget build(BuildContext context) {
    return ModalHelpBottomSheet(
      height: height,
      text:
          text,
      buttons: [
        if(imagePath != null)
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 200,
            height: 200,
            margin: const EdgeInsets.only(bottom: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath!,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: const Color.fromARGB(255, 71, 169, 218),
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 16,
              ),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Inter",
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Fechar",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}