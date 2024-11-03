import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function? onChanged;
  final int? maxLines;

  const InputField({
    super.key,
    required this.text,
    required this.controller,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.text, 
      cursorColor: Colors.grey,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xF6F6F6F6),
        labelText: text,
        labelStyle: Theme.of(context).textTheme.labelLarge,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.lightBlue, 
            width: 1.0
          ), 
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 17
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red, 
            width: 1.6
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.6
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        errorText: validator != null ? validator!(controller.text) : null,
        errorStyle: const TextStyle(
          fontSize: 12, 
          height: 0.5, 
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
      ),
      onChanged: (value) {
        onChanged?.call(value);
      },
    );
  }
}