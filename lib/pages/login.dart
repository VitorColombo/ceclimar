import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/widgets/header_widget.dart';
import 'package:tcc_ceclimar/widgets/input_field.dart';
import 'package:tcc_ceclimar/widgets/password_input.dart';
import 'package:tcc_ceclimar/widgets/send_btn.dart';
import 'package:tcc_ceclimar/widgets/send_google_btn.dart';

import '../controller/sign_user_controller.dart';
import '../widgets/no_animation_push.dart';
import 'sign_user.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  final String email;

  const LoginPage({Key? key, required this.email}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final SignUserController _controller = SignUserController();
  final _formKey = GlobalKey<FormState>();
  final _cadastroKey = GlobalKey<CadastroUsuarioPageState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.emailController.text = widget.email;
  }

  bool _validateForm() {
    setState(() {
      _controller.validateLogin();
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
                            const Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'ENTRAR',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 111, 130)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        NoAnimationPageRoute(
                                          builder: (context) => CadastroUsuarioPage(
                                            key: _cadastroKey, 
                                            email: _controller.emailController.text,
                                          ),
                                        ),
                                      );                                  
                                    },
                                    child: const Text(
                                      'CADASTRAR',
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
                          ],
                        ),
                        const SizedBox(height: 20),
                        InputField(
                          text: "E-mail", 
                          controller: _controller.emailController, 
                          validator: (value) => _controller.emailError,
                        ),
                        const SizedBox(height: 16),
                        Column(
                          children: [
                            PasswordInput(
                              text: "Senha", 
                              controller: _controller.passController, 
                              validator: (value) => _controller.passError
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      NoAnimationPageRoute( //todo alterar rota para recuperação de senha
                                        builder: (context) => CadastroUsuarioPage(
                                          key: _cadastroKey, 
                                          email: _controller.emailController.text,
                                        ),
                                      ),
                                    );                                  
                                  },
                                  child: const Text(
                                    'Esqueci minha senha',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 111, 130),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: 
                            SendBtn(
                              text: "Entrar", 
                              onValidate: _validateForm
                            ),
                        ),
                        const SizedBox(height: 16),
                        const SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: SendGoogleBtn(
                            text: "Entrar com Google",
                          ),
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