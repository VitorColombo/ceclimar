import 'package:flutter/material.dart';
import '../models/register_response.dart';

class BadgeItem extends StatelessWidget {
  final RegisterResponse register;

  const BadgeItem({super.key, required this.register});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 110,
                height: 110,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Align(
                    alignment: Alignment.center,
                    child: register.animal.badge,
                    ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}