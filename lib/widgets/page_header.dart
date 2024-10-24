import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final String text;
  final Widget? icon;
  final Function()? onTap;
  final Color color;

  const PageHeader({
    super.key,
    required this.text,
    this.onTap,
    this.icon,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    List<String> texts = text.split(',');

    return Container(
      padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
      child: SizedBox(
        height: 80,
        child: Stack(
          children: [
            Row(
              children: [
                if (icon != null)
                  GestureDetector(
                    onTap: onTap,
                    child: icon,
                  ),
                const SizedBox(width: 10.0, height: 80.0),
                Text(
                  texts[0],
                  style: TextStyle(
                    color: color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (texts.length > 1)
              Positioned(
                top: 55,
                left: 34,
                child: Text(
                  texts[1],
                  style: const TextStyle(
                    color: Color.fromARGB(255, 71, 169, 218),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}