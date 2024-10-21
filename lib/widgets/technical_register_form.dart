import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/widgets/custom_switch.dart';
import 'package:tcc_ceclimar/widgets/input_field.dart';
import 'package:tcc_ceclimar/widgets/send_btn.dart';
import 'package:tcc_ceclimar/widgets/send_btn_disabled.dart';

import '../controller/new_register_form_controller.dart';
import 'add_image_widget.dart';
import 'modal_help_register_image_btnsheet.dart';

class TechnicalRegisterForm extends StatefulWidget {
  @override
  State<TechnicalRegisterForm> createState() => _TechnicalRegisterFormState();
}

class _TechnicalRegisterFormState extends State<TechnicalRegisterForm> {
  final _formController = NewRegisterFormController();
  final _formKey = GlobalKey<FormState>();
  bool isSwitchOn = false;
  bool isBtnEnabled = false;
  final List<String> classes = ["teste1", "teste2", "teste3"]; //todo receber dados da API
  String? _selectedClass;

  @override
  void initState() {
    super.initState();
    _formController.nameController.addListener(_updateBtnStatus);
    _formController.hourController.addListener(_updateBtnStatus);
    _formController.speciesController.addListener(_updateBtnStatus);
    _formController.cityController.addListener(_updateBtnStatus);
    _formController.beachSpotController.addListener(_updateBtnStatus);
  }

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    setState(() {
      _formController.validateTechnicalForm();
    });
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
      isBtnEnabled = _formController.isBtnEnabledTechnical();
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
            const SizedBox(height: 16),
            InputField(
              text: "Espécie",
              controller: _formController.speciesController,
              validator: (value) => _formController.speciesError,
              onChanged: (_) => _updateBtnStatus(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: InputField(
                    text: "Município",
                    controller: _formController.cityController,
                    validator: (value) => _formController.cityError,
                    onChanged: (_) => _updateBtnStatus(),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 115,
                  child: InputField(
                    text: "Nº Guarita",
                    controller: _formController.beachSpotController,
                    validator: (value) => _formController.beachSpotError,
                    onChanged: (_) => _updateBtnStatus(),
                  ),
                ),
              ],
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
            SizedBox(
              height: 180,
              child: InputField(
                text: "Observações (Opcional)",
                controller: _formController.obsController,
                validator: (value) => _formController.obsError,
                onChanged: (_) => _updateBtnStatus(),
                maxLines: 10,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.only(right: 23, left: 15),
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xF6F6F6F6),
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                padding: const EdgeInsets.symmetric(vertical: 3.5),
                menuMaxHeight: 400,
                borderRadius: BorderRadius.circular(10),
                style: Theme.of(context).textTheme.labelMedium,
                isExpanded: true,
                value: _selectedClass,
                hint: Text("Classe (Opcional)", style: Theme.of(context).textTheme.labelLarge),
                items: classes.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedClass = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            InputField(
              text: "Ordem (Opcional)",
              controller: _formController.orderController,
              validator: (value) => _formController.orderError,
              onChanged: (_) => _updateBtnStatus(),
            ),
            const SizedBox(height: 16),
            InputField(
              text: "Família (Opcional)",
              controller: _formController.familyController,
              validator: (value) => _formController.familyError,
              onChanged: (_) => _updateBtnStatus(),
            ),
            const SizedBox(height: 16),
            InputField(
              text: "Gênero (Opcional)",
              controller: _formController.genderController,
              validator: (value) => _formController.genderError,
              onChanged: (_) => _updateBtnStatus(),
            ),
            const SizedBox(height: 16),
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
              ),
            const SizedBox(height: 26)
          ],
        ),
      ),
    );
  }

  void _showImageObservationBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const ModalHelpRegisterImageBottomSheet();
      },
    );
  }
}