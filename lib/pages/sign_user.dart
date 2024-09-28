import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/controller/sign_user_controller.dart';
import 'package:tcc_ceclimar/pages/login.dart';
import 'package:tcc_ceclimar/widgets/header_widget.dart';
import 'package:tcc_ceclimar/widgets/input_field.dart';
import 'package:tcc_ceclimar/widgets/send_btn.dart';

import '../widgets/no_animation_push.dart';

class CadastroUsuarioPage extends StatefulWidget {
  static const String routeName = '/cadastrar';

  const CadastroUsuarioPage({Key? key}) : super(key: key);

  @override
  _CadastroUsuarioPageState createState() => _CadastroUsuarioPageState();
}

class _CadastroUsuarioPageState extends State<CadastroUsuarioPage> {
  final SignUserController _controller = SignUserController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  void dispose() {
    _controller.emailController.dispose();
    _controller.nameController.dispose();

    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
                            Expanded(
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap:() {
                                      Navigator.pushReplacement(
                                        context,
                                        NoAnimationPageRoute(
                                          builder: (context) => const LoginPage(),
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
                                      color: Color.fromARGB(255, 0, 111, 130)
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
                          validator: _controller.validateName
                        ),
                        const SizedBox(height: 16),
                        InputField(
                          text: "E-mail",
                          controller: _controller.emailController,
                          validator: _controller.validateEmail
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          obscureText: _obscureText,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF6F6F6),
                            labelText: "Senha",
                            labelStyle: const TextStyle(color: Colors.grey),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Color(0xFFE8E8E8), width: 0.4),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue, width: 1.6),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            floatingLabelStyle: const TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 20,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText ? Icons.visibility : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          obscureText: _obscureText,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor:  Color(0xFFF6F6F6),
                            labelText: "Confirme sua senha",
                            labelStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Color(0xFFE8E8E8), width: 0.4),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue, width: 1.6),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            floatingLabelStyle: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: SendBtn(text: "Cadastrar", onValidate: _controller.validateSignIn),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: Color.fromARGB(255, 0, 111, 130)
                                )
                              ),
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 16,
                              ),
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: const Text(
                              "Cadastrar com Google",
                              style: TextStyle(color: Color.fromARGB(255, 0, 111, 130)), 
                            ),
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