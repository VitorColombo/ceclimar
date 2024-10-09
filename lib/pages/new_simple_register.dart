import 'package:flutter/material.dart';
import '../widgets/page_header.dart';
import '../widgets/simple_register_form.dart';

class NewSimpleRegister extends StatefulWidget {
  static const String routeName = '/newRegister';
  final Function(int) updateIndex;

  const NewSimpleRegister({
    super.key,
    this.updateIndex = _defaultUpdateIndex,
  });

  static void _defaultUpdateIndex(int index) {
  }

  @override
  _NewSimpleRegisterState createState() => _NewSimpleRegisterState();
}

class _NewSimpleRegisterState extends State<NewSimpleRegister> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PageHeader(
            text: "Novo registro,Simples",
            icon: const Icon(Icons.arrow_back),
            onTap: () => widget.updateIndex(0),
          ),
          Expanded(
            child: SimpleRegisterForm(), 
          ),
        ],
      ),
    );
  }
}