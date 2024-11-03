import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/controller/auth_user_controller.dart';
import 'package:tcc_ceclimar/pages/login.dart';
import 'package:tcc_ceclimar/widgets/header_banner_widget.dart';
import 'package:tcc_ceclimar/widgets/input_field.dart';
import 'package:tcc_ceclimar/widgets/password_input.dart';
import 'package:tcc_ceclimar/widgets/send_btn.dart';

import '../widgets/no_animation_push.dart';
import '../widgets/send_google_btn.dart';

class NewUserPage extends StatefulWidget {
  static const String routeName = '/cadastrar';
  final String email;

  const NewUserPage({Key? key, required this.email}) : super(key: key);

  @override
  NewUserPageState createState() => NewUserPageState();
}

class NewUserPageState extends State<NewUserPage> {
  final AuthenticationController _controller = AuthenticationController();
  final _formKey = GlobalKey<FormState>();
  final _loginKey = GlobalKey<LoginPageState>();

  @override
  void dispose() {
    _controller.emailController.dispose();
    _controller.nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.emailController.text = widget.email;
  }

    bool _validateForm() {
    setState(() {
      _controller.validateSignIn();
    });
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView( 
        slivers: [
          const SliverAppBar( 
            expandedHeight: 300,
            backgroundColor: Colors.white,
            shadowColor: Color.fromARGB(0, 173, 145, 145),
            flexibleSpace: FlexibleSpaceBar(
              background: HeaderBannerWidget(image: AssetImage('assets/images/logo.png')),
            ),
            pinned: true, 
            floating: false,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap:() {
                                      Navigator.pushReplacement(
                                        context,
                                        NoAnimationPageRoute(
                                          builder: (context) => LoginPage(
                                            key: _loginKey,
                                            email: _controller.emailController.text,
                                          ),
                                        ),
                                      );                                  
                                    },
                                    child: const Text(
                                      'ENTRAR',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'CADASTRAR',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 71, 169, 218)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        InputField(
                          text: "Nome",
                          controller: _controller.nameController,
                          validator: (value) => _controller.nameError
                        ),
                        const SizedBox(height: 16),
                        InputField(
                          text: "E-mail",
                          controller: _controller.emailController,
                          validator: (value) => _controller.emailError
                        ),
                        const SizedBox(height: 16),
                        PasswordInput(
                          text: "Senha",
                          controller: _controller.passController, 
                          validator: (value) => _controller.passError
                        ),
                        const SizedBox(height: 16),
                        PasswordInput(
                          text: "Confirme sua senha", 
                          controller: _controller.passConfController, 
                          validator: (value) => _controller.passConfError
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: SendBtn(
                            text: "Cadastrar", 
                            onValidate: _validateForm, 
                            onSend: () => _controller.signUpUser(context)
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: SendGoogleBtn(
                            text: "Cadastrar com Google",
                            onSend: () => _controller.signInWithGoogle(context),
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    );
  }
}