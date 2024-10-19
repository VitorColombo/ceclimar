import 'package:flutter/material.dart';

import 'modal_help_bottomsheet.dart';

class ModalHelpRegisterImageBottomSheet extends StatelessWidget {
  const ModalHelpRegisterImageBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ModalHelpBottomSheet(
      text:
          "Sugerimos o envio de 2 imagens da ocorrência, sendo uma com escala e outra sem. Para representar a escala, podem ser usados objetos ou até mesmo o pé.",
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