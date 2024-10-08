import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/pages/base_page.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final IconData icon; 
  final Color backgroundColor;
  final Color hoverColor; 
  final double size;

  const CustomFloatingActionButton({
    Key? key,
    this.icon = Icons.add,
    this.backgroundColor = const Color.fromARGB(255, 2, 52, 87),
    this.hoverColor = const Color.fromARGB(255, 31, 73, 95),
    this.size = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -20),
      child: SizedBox(
        height: size,
        width: size,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(BasePage.routeName, arguments: 3);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: const CircleBorder(),
            padding: EdgeInsets.zero,
            elevation: 0,
          ),
          child: Icon(icon, size: 50),
        ),
      ),
    );
  }
}