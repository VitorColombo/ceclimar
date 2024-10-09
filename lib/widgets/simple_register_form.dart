import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/widgets/input_field.dart';

import '../controller/new_register_form_controller.dart';

class SimpleRegisterForm extends StatefulWidget {
  @override
  State<SimpleRegisterForm> createState() => _SimpleRegisterFormState();
}

class _SimpleRegisterFormState extends State<SimpleRegisterForm> {
  final _formController = NewRegisterFormController();
  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
          //   InputField(
          //     text: "Nome",
          //     controller: _controller.nameController,
          //     validator: (value) => _controller.nameError
          //   ),
          //   const SizedBox(height: 16),
          //   InputField(
          //     text: "E-mail",
          //     controller: _controller.emailController,
          //     validator: (value) => _controller.emailError
          //   ),
          //   const SizedBox(height: 16),
          //   PasswordInput(
          //     text: "Senha",
          //     controller: _controller.passController, 
          //     validator: (value) => _controller.passError
          //   ),
          //   const SizedBox(height: 16),
          //   PasswordInput(
          //     text: "Confirme sua senha", 
          //     controller: _controller.passConfController, 
          //     validator: (value) => _controller.passConfError
          //   ),
          //   const SizedBox(height: 24),
          //   SizedBox(
          //     width: double.infinity,
          //     height: 56,
          //     child: SendBtn(text: "Cadastrar", onValidate: _validateForm, onSend: () => _controller.signUpUser(context)),
          //   ),
          //   const SizedBox(height: 16),
          //   SizedBox(
          //     width: double.infinity,
          //     height: 56,
          //     child: SendGoogleBtn(
          //       text: "Cadastrar com Google",
          //       onSend: () => _controller.signInWithGoogle(),
          //     )
          //   ),
          ],
        ),
      ),
    );
  }
}