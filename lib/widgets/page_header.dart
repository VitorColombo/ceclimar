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
    return Container(
      padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            if (icon != null)
              GestureDetector(
                onTap: onTap,
                child: icon
              ),
            if(icon == null)
              const SizedBox(width: 24.0),
            const SizedBox(width: 10.0),
            Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}