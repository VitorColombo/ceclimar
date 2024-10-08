import 'package:flutter/material.dart';
import '../widgets/page_header.dart';

class LocalAnimals extends StatelessWidget {
  static const String routeName = '/localAnimals'; 
  final Function(int) updateIndex;

  const LocalAnimals({super.key, this.updateIndex = _defaultUpdateIndex});

  static void _defaultUpdateIndex(int index) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PageHeader(text: "Fauna local", icon: const Icon(Icons.arrow_back), onTap: () => updateIndex(0)),
        ],
      ),
    );
  }
}