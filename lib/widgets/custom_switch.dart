import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;
  final void Function()? onTap;

  const CustomSwitch({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
    this.onTap
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
        Text(
          widget.text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        GestureDetector(
          onTap: widget.onTap ?? () {},
          child: 
            Icon(
              Icons.info_outline, 
              size: 16
            )
        ),
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