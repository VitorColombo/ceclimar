import 'package:flutter/material.dart';
import 'modal_help_bottomsheet.dart';

class ModalHelpRegisterImageBottomSheet extends StatelessWidget {
  final String text;

  const ModalHelpRegisterImageBottomSheet({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return ModalHelpBottomSheet(
      text:
          text,
      buttons: [
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