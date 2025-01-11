import 'package:flutter/material.dart';

class ModalHelpBottomSheet extends StatefulWidget {
  final String text;
  final double height;
  final List<Widget> buttons;
  const ModalHelpBottomSheet({
    super.key, 
    required this.text, 
    required this.buttons,
    this.height = 300,
    });

  @override
  State<ModalHelpBottomSheet> createState() => _ModalHelpBottomSheetState();
}

class _ModalHelpBottomSheetState extends State<ModalHelpBottomSheet> {
  @override
  Widget build(BuildContext context) { 
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      height: widget.height,
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.info_outline, size: 30, color: Colors.black),
            const SizedBox(height: 20),
            Text(
              widget.text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            ...widget.buttons.map((button) => SizedBox(
              width: double.infinity,
              child: button,
            )),
          ],
        ),
      ),
    );
  }
}