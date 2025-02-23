import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final String text;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final void Function()? onTap;
  final bool isDisabled; 

  const CustomSwitch({
    super.key,
    required this.text,
    required this.value,
    this.onChanged,
    this.onTap,
    this.isDisabled = false, 
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
          onChanged: widget.isDisabled ? null : (bool value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
        ),
      ],
    );
  }
}