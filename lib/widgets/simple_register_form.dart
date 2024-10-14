import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/widgets/custom_switch.dart';
import 'package:tcc_ceclimar/widgets/input_field.dart';
import 'package:tcc_ceclimar/widgets/send_btn.dart';
import 'package:tcc_ceclimar/widgets/send_btn_disabled.dart';

import '../controller/new_register_form_controller.dart';
import 'add_image_widget.dart';
import 'modal_help_bottomsheet.dart';

class SimpleRegisterForm extends StatefulWidget {
  @override
  State<SimpleRegisterForm> createState() => _SimpleRegisterFormState();
}

class _SimpleRegisterFormState extends State<SimpleRegisterForm> {
  final _formController = NewRegisterFormController();
  final _formKey = GlobalKey<FormState>();
  bool isSwitchOn = false;
  bool isBtnEnabled = false;

  @override
  void initState() {
    super.initState();
    _formController.nameController.addListener(_updateBtnStatus);
    _formController.hourController.addListener(_updateBtnStatus);
  }

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    _formKey.currentState?.save();
    return _formKey.currentState?.validate() ?? false;
  }

  void _onSwitchChanged(bool value) {
    setState(() {
      _formController.changeSwitch();
      isSwitchOn = value;
      _updateBtnStatus();
    });
  }

  void _updateBtnStatus() {
    setState(() {
      isBtnEnabled = _formController.isBtnEnable();
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
            GestureDetector(
              onTap: () {
                _showImageObservationBottomSheet();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 45),
                  Text(
                    "Dicas para as fotografias do registro ",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Icon(Icons.info_outline, size: 16),
                ],
              ),
            ),
            const SizedBox(height: 16),
            InputField(
              text: "Nome Popular",
              controller: _formController.nameController,
              validator: (value) => _formController.nameError,
              onChanged: (_) => _updateBtnStatus(),
            ),
            const SizedBox(height: 9),
            CustomSwitch(
              text: "Presenciou o animal encalhando?",
              value: isSwitchOn,
              onChanged: _onSwitchChanged
            ),
            const SizedBox(height: 9),
            if (isSwitchOn)
              Column(
                children: [
                  InputField(
                    text: "Horário aproximado",
                    controller: _formController.hourController,
                    validator: (value) => _formController.hourError,
                    onChanged: (_) => _updateBtnStatus(),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            if(isBtnEnabled)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: SendBtn(
                    onSend: () => _formController.sendRegister(context),
                    onValidate: _validateForm,
                    text: "Enviar Registro",
                ),
              )
            else
              const SizedBox(
                width: double.infinity,
                height: 56,
                child: DisabledSendBtn(
                text: "Enviar Registro",
                ),
              )
          ],
        ),
      ),
    );
  }

  void _showImageObservationBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ModalHelpBottomSheet(
          text:
              "Sugerimos o envio de 2 imagens da ocorrência, sendo uma com escala e outra sem. Para representar a escala, podem ser usados objetos ou até mesmo o pé.",
          buttons: [
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color.fromARGB(255, 71, 169, 218),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter",
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Fechar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}