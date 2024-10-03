import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/widgets/header_widget.dart';
import 'package:tcc_ceclimar/widgets/input_field.dart';
import 'package:tcc_ceclimar/widgets/send_btn.dart';

import '../controller/auth_user_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgot_password';
  final String email;

  const ForgotPasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final AuthenticationController _controller = AuthenticationController();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _showSuccessMessage = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    setState(() {
      _controller.validateForgotPass();
    });
    return _formKey.currentState?.validate() ?? false;
  }

  void _sendPasswordResetEmail() {
  //todo verificar se o email esta presente no BD

    setState(() {
      _showSuccessMessage = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 300,
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: HeaderWidget(),
            ),
            pinned: true,
            floating: false,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                AnimatedCrossFade(
                  firstChild: _buildPasswordForm(),
                  secondChild: _buildSuccessMessage(),
                  crossFadeState: _showSuccessMessage
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 500),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    );
  }

  Widget _buildPasswordForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Esqueceu sua senha?',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Por favor informe o e-mail associado a sua conta para que seja enviado um link de alteração de senha',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 32.0),
            InputField(
              text: 'Email',
              controller: _controller.emailController,
              validator: (value) => _controller.emailError
            ),
            const SizedBox(height: 32.0),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: SendBtn(
                text: 'Recuperar senha',
                onValidate: () {
                  if (_validateForm()) {
                    _sendPasswordResetEmail();
                  }
                  return true; 
                },
                onSend: _controller.sendPasswordResetEmail,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Envio realizado com sucesso!',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Cheque seu e-mail para recuperar o acesso a partir do link enviado',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          SizedBox(height: 150),
          Icon(Icons.check_circle, size: 120, color: Colors.green),
        ],
      ),
    );
  }
}