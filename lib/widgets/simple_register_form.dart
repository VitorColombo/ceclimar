import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/widgets/circular_image_widget.dart';
import 'package:tcc_ceclimar/widgets/custom_switch.dart';
import 'package:tcc_ceclimar/widgets/input_field.dart';

import '../controller/new_register_form_controller.dart';
import 'add_image_widget.dart';

class SimpleRegisterForm extends StatefulWidget {
  @override
  State<SimpleRegisterForm> createState() => _SimpleRegisterFormState();
}

class _SimpleRegisterFormState extends State<SimpleRegisterForm> {
  final _formController = NewRegisterFormController();
  final _formKey = GlobalKey<FormState>();
  bool isSwitchOn = false;

  @override
  void dispose() {
      //todo
    super.dispose();
  }

    bool _validateForm() {
    setState(() {
      //todo
    });
    return _formKey.currentState?.validate() ?? false;
  }

  void _onSwitchChanged(bool value) {
    setState(() {
      isSwitchOn = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const ImageSelector(),
            const SizedBox(height: 16),
            InputField(
              text: "Nome Popular",
              controller: _formController.nameController,
              validator: (value) => _formController.nameError
            ),
            const SizedBox(height: 9),
            CustomSwitch(text: "Presenciou o animal chegando na areia?", value: isSwitchOn, onChanged: _onSwitchChanged),
            const SizedBox(height: 9),
            if (isSwitchOn)
              InputField(
                text: "Horário aproximado",
                controller: _formController.horaController,
                validator: (value) => _formController.horaError,
              ),
          ],
        ),
      ),
    );
  }
}