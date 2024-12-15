import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/controller/evaluate_register_controller.dart';
import 'package:tcc_ceclimar/models/register_response.dart';
import 'package:tcc_ceclimar/widgets/input_field.dart';
import 'package:tcc_ceclimar/widgets/radio_btn_animal_state.dart';
import 'package:tcc_ceclimar/widgets/search_input_field.dart';
import 'package:tcc_ceclimar/widgets/send_btn.dart';

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
  final List<String> species = ["penguim", "gaviao", "arubinha", "lobo marinho", "pardal", "gaviao", "arubinha", "lobo marinho", "pardal""gaviao", "arubinha", "lobo marinho", "pardal"];
  final FocusNode _speciesFocusNode = FocusNode();
  final FocusNode _classFocusNode = FocusNode();
  final FocusNode _orderFocusNode = FocusNode();
  final FocusNode _familyFocusNode = FocusNode();
  final FocusNode _genusFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _formController.nameController.text = widget.register.popularName;
    _formController.speciesController.text = widget.register.species != null ? widget.register.species! : '';
    _formController.classController.text = widget.register.classe != null ? widget.register.classe! : '';
    _formController.orderController.text = widget.register.order != null ? widget.register.order! : '';
    _formController.familyController.text = widget.register.family != null ? widget.register.family! : '';
    _formController.genuController.text = widget.register.genu != null ? widget.register.genu! : '';
    _formController.obsController.text = widget.register.observation != null ? widget.register.observation! : '';
  
    _speciesFocusNode.addListener(_handleFocusChange);
    _classFocusNode.addListener(_handleFocusChange);
    _orderFocusNode.addListener(_handleFocusChange);
    _familyFocusNode.addListener(_handleFocusChange);
    _genusFocusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (_speciesFocusNode.hasFocus ||
        _classFocusNode.hasFocus ||
        _orderFocusNode.hasFocus ||
        _familyFocusNode.hasFocus ||
        _genusFocusNode.hasFocus) {
    }
  }

  @override
  void dispose() {
    _speciesFocusNode.dispose();
    _classFocusNode.dispose();
    _orderFocusNode.dispose();
    _familyFocusNode.dispose();
    _genusFocusNode.dispose();
    _formController.dispose();
    _formController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    setState(() {
      _formController.validateForm();
    });
    return _formKey.currentState?.validate() ?? false;
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
            ),
            const SizedBox(height: 16),
            SearchInputField(
              text: "Espécie",
              controller: _formController.speciesController,
              validator: (value) => _formController.speciesError,
              items: species, //todo
              focusNode: _speciesFocusNode,
            ),
            const SizedBox(height: 16),
            SearchInputField(
              text: "Classe",
              controller: _formController.classController,
              validator: (value) => _formController.classError,
              items: species, //todo
              focusNode: _classFocusNode,
            ),
            const SizedBox(height: 16),
            SearchInputField(
              text: "Ordem",
              controller: _formController.orderController,
              validator: (value) => _formController.orderError,
              items: species, //todo
              focusNode: _orderFocusNode,
            ),
            const SizedBox(height: 16),
            SearchInputField(
              text: "Família",
              controller: _formController.familyController,
              validator: (value) => _formController.familyError,
              items: species,//todo
              focusNode: _familyFocusNode,
            ),
            const SizedBox(height: 16),
            SearchInputField(
              text: "Gênero",
              controller: _formController.genuController,
              validator: (value) => _formController.genuError,
              items: species,
              focusNode: _genusFocusNode,
            ),
            RadioRowAnimal(
              onChanged:  (String value) {
                setState(() {
                  _formController.animalStateController.text = value;
                });
              },
            ),
            const SizedBox(height: 9),
            SizedBox(
              height: 180,
              child: InputField(
                text: "Informações Adicionais (Opcional)",
                controller: _formController.obsController,
                validator: (value) => _formController.obsError,
                maxLines: 10,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: SendBtn(
                  onSend: () => _formController.sendEvaluation(context, widget.register),
                  onValidate: _validateForm,
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