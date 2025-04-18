
import 'package:flutter/material.dart';

abstract class BaseHomeCard extends StatelessWidget {
  final String text;
  final Widget icon;

  const BaseHomeCard({
    super.key,
    required this.text,
    required this.icon,
  });

  void onTapAction(BuildContext context);

  @override
  Widget build(BuildContext context) {
    double textSize = getResponsiveTextSize(context, 16.0);

    return Stack(
      children: [
        Card(
          shadowColor: Color.fromRGBO(0, 0, 0, 0.7),
          elevation: 6.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: const Color.fromARGB(255, 71, 169, 218),
          child: Padding(
            padding: const EdgeInsets.only(top: 7.0, bottom: 5.0, left: 15.0, right: 15.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: textSize),
                    ),
                  ),
                  const SizedBox(height: 14.0),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: icon,
                  ),
                ],
              ),
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onTapAction(context),
            splashColor: Color.fromRGBO(255, 255, 255, 0.2),
            highlightColor: Color.fromRGBO(255, 255, 255, 0.2),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ],
    );
  }
}

double getResponsiveTextSize(BuildContext context, double baseSize) {
  double screenWidth = MediaQuery.of(context).size.width;
  return baseSize * (screenWidth / 375.0);
}