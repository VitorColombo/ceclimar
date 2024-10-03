import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const InputField({
    Key? key,
    required this.text,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.text, 
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xF6F6F6F6),
        labelText: text,
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
          fontSize: 17
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.6),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.6),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        errorText: validator != null ? validator!(controller.text) : null,
        errorStyle: const TextStyle(
          fontSize: 12, 
          height: 0.5, 
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 17.0, horizontal: 10.0),
      ),
    );
  }
}