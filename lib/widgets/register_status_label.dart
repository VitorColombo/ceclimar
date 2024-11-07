import 'package:flutter/material.dart';

class StatusLabel extends StatelessWidget {
  final String status;
  const StatusLabel({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: status == "Validado" ? Color.fromARGB(255, 178, 227, 170) : Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12,
        ),
      ),
    );
  }
}