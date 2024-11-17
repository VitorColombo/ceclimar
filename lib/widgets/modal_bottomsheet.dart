import 'package:flutter/material.dart';

class ModalBottomSheet extends StatefulWidget {
  final String text;
  final List<Widget> buttons;
  const ModalBottomSheet({super.key, required this.text, required this.buttons});

  @override
  State<ModalBottomSheet> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  @override
  Widget build(BuildContext context) { 
    return Container(
      padding: const EdgeInsets.only(top: 0, left: 40, right: 40, bottom: 0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      height: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 30),
            ...widget.buttons.map((button) => SizedBox(
              width: double.infinity,
              child: button,
            )).toList(),
          ],
        ),
      ),
    );
  }
}