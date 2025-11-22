import 'package:flutter/material.dart';

class SendBtn extends StatefulWidget {
  final String text;
  final Function onValidate;
  final Function onSend;

  const SendBtn({
    super.key, 
    required this.text, 
    required this.onValidate, 
    required this.onSend
  });

  @override
  SendBtnState createState() => SendBtnState();
}

class SendBtnState extends State<SendBtn> {
  bool _isLoading = false;

  void _handlePress() async {
    if (widget.onValidate()) {
      if(mounted){
        setState(() {
          _isLoading = true;
        });
      }
      try {
        await widget.onSend();
      } finally {
        if(mounted){
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, verifique os dados de entrada.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _isLoading ? null : _handlePress,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: const Color.fromRGBO(71, 169, 218, 1),
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
      child: Center(
        child: _isLoading
            ? const SizedBox(
              height: 30,
              width: 24,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 3,
                ),
            )
            : Text(
                widget.text,
                style: const TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}