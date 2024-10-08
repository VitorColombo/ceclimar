import 'package:flutter/material.dart';
import '../widgets/page_header.dart';

class MyRegisters extends StatelessWidget {
  static const String routeName = '/myregisters'; 
  final Function(int) updateIndex;

  const MyRegisters({super.key, this.updateIndex = _defaultUpdateIndex});

  static void _defaultUpdateIndex(int index) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PageHeader(text: "Meus registros", icon: const Icon(Icons.arrow_back), onTap: () => updateIndex(0)),
        ],
      ),
    );
  }
}