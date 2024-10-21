import 'package:flutter/material.dart';

class DisabledSendBtn extends StatelessWidget {
  final String text;

  const DisabledSendBtn({super.key, required this.text,});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
      },
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: const Color.fromARGB(255, 199, 199, 199),
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