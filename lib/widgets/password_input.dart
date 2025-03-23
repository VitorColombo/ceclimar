import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordInput extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const PasswordInput({
    super.key,
    required this.text,
    required this.controller,
    this.validator,
  });

  @override
  State<PasswordInput> createState() => PasswordInputState();
}

class PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;

  bool get obscureText => _obscureText;

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
          cursorColor: Colors.grey,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xF6F6F6F6),
            labelText: widget.text,
            labelStyle: const TextStyle(color: Colors.grey),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0,
                style: BorderStyle.solid,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlue, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            floatingLabelStyle: const TextStyle(
              color: Colors.grey,
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
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'\s')),
          ],
        ),
      ],
    );
  }
}