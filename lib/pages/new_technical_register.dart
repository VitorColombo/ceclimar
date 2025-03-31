import 'package:flutter/material.dart';
import '../widgets/page_header.dart';
import '../widgets/technical_register_form.dart';

class NewTechnicalRegister extends StatefulWidget {
  static const String routeName = '/newTechnicalRegister';
  final Function(int) updateIndex;

  const NewTechnicalRegister({
    super.key,
    this.updateIndex = _defaultUpdateIndex,
  });

  static void _defaultUpdateIndex(int index) {
  }

  @override
  NewTechnicalRegisterState createState() => NewTechnicalRegisterState();
}

class NewTechnicalRegisterState extends State<NewTechnicalRegister> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            PageHeader(
              text: "Novo registro,Técnico",
              icon: const Icon(Icons.arrow_back),
              onTap: () => widget.updateIndex(0),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TechnicalRegisterForm()
                      ],
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}