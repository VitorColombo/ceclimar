import 'package:flutter/material.dart';

class SendGoogleBtn extends StatefulWidget {
  final String text;
  final Function onSend;

  const SendGoogleBtn({
    super.key,
    required this.text,
    required this.onSend,
  });

  @override
  SendGoogleBtnState createState() => SendGoogleBtnState();
}

class SendGoogleBtnState extends State<SendGoogleBtn> {
  bool _isLoading = false;

  void _handlePress() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    try {
      await widget.onSend();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buttonContent;
    if (_isLoading) {
      buttonContent = const SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Color.fromARGB(255, 71, 169, 218),
          ),
          strokeWidth: 3,
        ),
      );
    } else {
      buttonContent = Row(
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
                widget.text,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color.fromARGB(255, 71, 169, 218)),
              ),
            ),
          ),
        ],
      );
    }

    return TextButton(
      onPressed: _isLoading ? null : _handlePress,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Color.fromARGB(255, 71, 169, 218),
          ),
        ),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 16,
        ),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          fontFamily: "Inter",
        ),
        minimumSize: const Size(0, 56),
      ),
      child: Center(child: buttonContent),
    );
  }
}
