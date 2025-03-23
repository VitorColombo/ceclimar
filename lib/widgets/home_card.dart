
import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/widgets/base_home_card.dart';

class HomeCard extends BaseHomeCard {
  final int index;
  final Function(int) updateIndex;

  const HomeCard({
    super.key,
    required super.text,
    required super.icon,
    required this.index,
    required this.updateIndex,
  });

  @override
  void onTapAction(BuildContext context) {
    updateIndex(index);
  }
}
