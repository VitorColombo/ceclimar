import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.text),
        Switch(
          value: widget.value,
          activeColor: const Color.fromARGB(255, 71, 169, 218),
          onChanged: (bool value) {
            widget.onChanged(value);
          },
        ),
      ],
    );
  }
}