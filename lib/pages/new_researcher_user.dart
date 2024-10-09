import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/controller/auth_user_controller.dart';
import 'package:tcc_ceclimar/widgets/header_banner_widget.dart';
import 'package:tcc_ceclimar/widgets/input_field.dart';
import 'package:tcc_ceclimar/widgets/password_input.dart';
import 'package:tcc_ceclimar/widgets/send_btn.dart';
import '../widgets/modal_bottomsheet.dart';

class NewResearcherPage extends StatefulWidget {
  static const String routeName = '/newResearcher';
  final Function(int) updateIndex;

  const NewResearcherPage({super.key, this.updateIndex = _defaultUpdateIndex});

  static void _defaultUpdateIndex(int index) {

  }
  
  @override
  NewResearcherPageState createState() => NewResearcherPageState();
}

class NewResearcherPageState extends State<NewResearcherPage> {
  final AuthenticationController _controller = AuthenticationController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.emailController.dispose();
    _controller.nameController.dispose();
    super.dispose();
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
            shadowColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: HeaderBannerWidget(),
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
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'CADASTRAR PESQUISADOR',
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
                            onSend: () => {
                              _showModalBottomSheet(context),
                            }
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

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalBottomSheet(
          text: "Usuário já cadastrado, deseja conceder o título de pesquisador?",
          buttons: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: const Color.fromARGB(255, 93, 176, 117), 
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter"
                ),
              ),
              child: const Text(
                "Sim",
                style: TextStyle(color: Colors.white), 
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: const Color.fromARGB(255, 232, 39, 39), 
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter"
                ),
              ),
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Colors.white), 
              ),
            ),
          ],
        );
      },
    );
  }
}