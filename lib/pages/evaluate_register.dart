import 'package:flutter/material.dart';
import '../widgets/page_header.dart';

class EvaluateRegister extends StatelessWidget {
  static const String routeName = '/evaluateRegister'; 
  final Function(int) updateIndex;

  const EvaluateRegister({super.key, this.updateIndex = _defaultUpdateIndex});

  static void _defaultUpdateIndex(int index) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PageHeader(text: "Avaliar registros", icon: const Icon(Icons.arrow_back), onTap: () => updateIndex(0)),
        ]
      ),
    );
  }
}