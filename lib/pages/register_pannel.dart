import 'package:flutter/material.dart';
import '../widgets/page_header.dart';

class RegisterPannel extends StatelessWidget {
  static const String routeName = '/registerPannel'; 
  final Function(int) updateIndex;

  const RegisterPannel({super.key, this.updateIndex = _defaultUpdateIndex});

  static void _defaultUpdateIndex(int index) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PageHeader(text: "Painel de registros", icon: const Icon(Icons.arrow_back), onTap: () => updateIndex(0)),
        ],
      ),
    );
  }
}