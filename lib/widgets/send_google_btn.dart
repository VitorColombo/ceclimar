import 'package:flutter/material.dart';

class SendGoogleBtn extends StatelessWidget {
  final String text;
  const SendGoogleBtn({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Color.fromARGB(255, 0, 111, 130),
          ),
        ),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 16,
        ),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/google-logo.png", 
            height: 24, 
          ),
          const SizedBox(width: 16), 
          Expanded(
            child: Transform.translate(
              offset: const Offset(-16, 0),
              child: Text(
                text,
                textAlign: TextAlign.center, 
                style: const TextStyle(color: Color.fromARGB(255, 0, 111, 130)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}