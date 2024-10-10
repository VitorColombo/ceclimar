import 'package:flutter/material.dart';

class SendBtn extends StatelessWidget {
  final String text;
  final Function onValidate;
  final Function onSend;

  const SendBtn({super.key, required this.text, required this.onValidate, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        bool isValid = onValidate();
        if (isValid) {
          onSend();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Por favor, verifique os dados de entrada.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
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
          fontFamily: "Inter"
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white), 
      ),
    );
  }
}