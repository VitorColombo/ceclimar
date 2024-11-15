import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/controller/evaluate_register_controller.dart';
import 'package:tcc_ceclimar/models/register_response.dart';
import 'package:tcc_ceclimar/widgets/input_field.dart';
import 'package:tcc_ceclimar/widgets/radio_btn_animal_state.dart';
import 'package:tcc_ceclimar/widgets/search_input_field.dart';
import 'package:tcc_ceclimar/widgets/send_btn.dart';
import 'package:tcc_ceclimar/widgets/send_btn_disabled.dart';

class EvaluateRegisterForm extends StatefulWidget {
  final RegisterResponse register;

  const EvaluateRegisterForm({
    super.key,
    required this.register
  });
  
  @override
  State<EvaluateRegisterForm> createState() => _EvaluateRegisterFormState();
}

class _EvaluateRegisterFormState extends State<EvaluateRegisterForm> {
  final _formController = EvaluateRegisterFormController();
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
            RadioListTileExample(),
            const SizedBox(height: 9),
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
            if(isBtnEnabled)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: SendBtn(
                    onSend: () => _formController.sendRegisterEvaluation(),
                    onValidate: _validateForm,
                    text: "Enviar Análise",
                ),
              )
            else
              const SizedBox(
                width: double.infinity,
                height: 56,
                child: DisabledSendBtn(
                    text: "Enviar Análise",
                ),
              ),
            const SizedBox(height: 26)
          ],
        ),
      ),
    );
  }
}