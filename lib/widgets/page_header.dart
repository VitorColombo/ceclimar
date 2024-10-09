import 'package:flutter/widgets.dart';

class PageHeader extends StatelessWidget {
  final String text;
  final Widget? icon;
  final Function()? onTap;

  const PageHeader({
    super.key,
    required this.text,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    List<String> texts = text.split(',');

    return Container(
      padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (texts.length > 1)
            Transform.translate(
              offset: const Offset(34, -25),
              child: Text(
                texts[1],
                style: const TextStyle(
                  color: Color.fromARGB(255, 71, 169, 218),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
        ],
      ),
    );
  }
}