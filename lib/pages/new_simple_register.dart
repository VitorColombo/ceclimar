import 'package:flutter/material.dart';

import 'package:tcc_ceclimar/widgets/simple_register_form.dart';
import 'package:tcc_ceclimar/widgets/page_header.dart';

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
  NewSimpleRegisterState createState() => NewSimpleRegisterState();
}

class NewSimpleRegisterState extends State<NewSimpleRegister> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PageHeader(
              text: "Novo registro,Simples",
              icon: const Icon(Icons.arrow_back),
              onTap: () => widget.updateIndex(0),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                children: [SimpleRegisterForm()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}