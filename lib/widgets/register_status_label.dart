import 'package:flutter/material.dart';

class StatusLabel extends StatefulWidget {
  final String status;
  final Color borderColor;
  const StatusLabel({super.key, required this.status, required this.borderColor});

  @override
  State<StatusLabel> createState() => _StatusLabelState();
}

class _StatusLabelState extends State<StatusLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: widget.status == "Validado" ? Color.fromARGB(255, 178, 227, 170) : Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: widget.borderColor,
          width: 2,
        ),
      ),
      child: Text(
        widget.status,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12,
        ),
      ),
    );
  }
}