import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/widgets/custom_switch.dart';
import 'package:tcc_ceclimar/widgets/input_field.dart';
import 'package:tcc_ceclimar/widgets/search_input_field.dart';
import 'package:tcc_ceclimar/widgets/send_btn.dart';
import 'package:tcc_ceclimar/widgets/send_btn_disabled.dart';

import '../controller/new_register_form_controller.dart';
import 'image_selector.dart';
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
  final List<String> species = ["penguim", "gaviao", "arubinha", "lobo marinho", "pardal", "gaviao", "arubinha", "lobo marinho", "pardal""gaviao", "arubinha", "lobo marinho", "pardal"];

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
            Stack(
              children: [
                ImageSelector(onImageSelected: _formController.setImage),
                Positioned(
                  top: 82,
                  child: ImageSelector(width: 50, height: 50, onImageSelected: _formController.setImage2)
                ),
              ],
            ),
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
            SearchInputField(
              text: "Espécie",
              controller: _formController.speciesController,
              validator: (value) => _formController.speciesError,
              onChanged: (_) => _updateBtnStatus(),
              items: species, //todo
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
              onChanged: _onSwitchChanged,
              onTap: _showSwitchInfoBottomSheet,
            ),
            const SizedBox(height: 9),
            if (isSwitchOn)
              Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                      setState(() {
                        _formController.hourController.text = pickedTime.format(context);
                        _updateBtnStatus();
                      });
                      }
                    },
                    child: AbsorbPointer(
                      child: InputField(
                      text: "Horário aproximado",
                      controller: _formController.hourController,
                      validator: (value) => _formController.hourError,
                      onChanged: (_) => _updateBtnStatus(),
                      ),
                    ),
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
            SearchInputField(
              text: "Classe (Opcional)",
              controller: _formController.classController,
              validator: (value) => _formController.classError,
              onChanged: (_) => _updateBtnStatus(),
              items: species, //todo
            ),
            const SizedBox(height: 16),
            SearchInputField(
              text: "Ordem (Opcional)",
              controller: _formController.orderController,
              validator: (value) => _formController.orderError,
              onChanged: (_) => _updateBtnStatus(),
              items: species, //todo
            ),
            const SizedBox(height: 16),
            SearchInputField(
              text: "Família (Opcional)",
              controller: _formController.familyController,
              validator: (value) => _formController.familyError,
              onChanged: (_) => _updateBtnStatus(),
              items: species,//todo
            ),
            const SizedBox(height: 16),
            SearchInputField(
              text: "Gênero (Opcional)",
              controller: _formController.genderController,
              validator: (value) => _formController.genderError,
              onChanged: (_) => _updateBtnStatus(),
              items: species, //todo
            ),
            const SizedBox(height: 16),
            if(isBtnEnabled)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: SendBtn(
                    onSend: () => _formController.sendTechnicalRegister(context),
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
        return const ModalHelpRegisterImageBottomSheet(text: "Sugerimos o envio de 2 imagens da ocorrência, sendo uma com escala e outra sem. Para representar a escala, podem ser usados objetos ou até mesmo o pé.");
      },
    );
  }

  void _showSwitchInfoBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const ModalHelpRegisterImageBottomSheet(text: "Marque esse campo se você presenciou o mar trazendo o animal para a faixa de areia.");
      },
    );
  }
}