import 'package:flutter/material.dart';
import '../widgets/page_header.dart';

class NewRegister extends StatelessWidget {
  static const String routeName = '/newRegister'; 
  final Function(int) updateIndex;

  const NewRegister({super.key, this.updateIndex = _defaultUpdateIndex});

  static void _defaultUpdateIndex(int index) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PageHeader(text: "Novo registro", icon: const Icon(Icons.arrow_back), onTap: () => updateIndex(0)),
        ],
      ),
    );
  }
}