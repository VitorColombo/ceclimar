import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const PasswordInput({
    Key? key,
    required this.text,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          obscureText: _obscureText,
          keyboardType: TextInputType.text,
          cursorColor: Colors.black,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xF6F6F6F6),
            labelText: widget.text,
            labelStyle: const TextStyle(color: Colors.grey),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Color(0xE8E8E8E8), width: .4),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlue, width: 1.6),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            floatingLabelStyle: const TextStyle(
              fontSize: 17,
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.6),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.6),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            errorText: widget.validator != null ? widget.validator!(widget.controller.text) : null,
            errorStyle: const TextStyle(
              fontSize: 12, 
              height: 0.5, 
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 17.0, horizontal: 10.0),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: _togglePasswordVisibility,
            ),
          ),  
        ),
      ],
    );
  }
}