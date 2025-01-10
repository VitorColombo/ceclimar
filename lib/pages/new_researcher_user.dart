import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc_ceclimar/controller/auth_user_controller.dart';
import 'package:tcc_ceclimar/utils/user_role.dart';
import 'package:tcc_ceclimar/widgets/header_banner_widget.dart';
import 'package:tcc_ceclimar/widgets/input_field.dart';
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
  bool _showPassword = false;
  String _generatedPassword = "";

  @override
  void dispose() {
    _controller.emailController.dispose();
    _controller.nameController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    setState(() {
      _controller.validateNewResearcher();
    });
    return _formKey.currentState?.validate() ?? false;
  }

  Future<void> _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Senha copiada!')),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView( 
        slivers: [
          const SliverAppBar( 
            expandedHeight: 250,
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
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
                                      color: Color.fromARGB(255, 71, 169, 218),
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
                        if (_showPassword)
                          Column(
                            children: [
                              const SizedBox(height: 24),
                              Text("Senha temporária gerada:"),
                              Padding(
   padding: const EdgeInsets.only(top: 8.0),
child: Container(
  width: 200,
  height: 50,
  decoration: BoxDecoration(
    color: Colors.grey[200],
    borderRadius: BorderRadius.circular(8.0),
  ),
  child: Stack(
    children: [
      Center(
        child: Text(
          _generatedPassword,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Positioned(
        right: 0,
        child: IconButton(
          onPressed: () => _copyToClipboard(_generatedPassword),
          icon: const Icon(Icons.copy, color: Colors.grey),
        ),
      ),
    ],
  ),
),
                              )
                            ],
                          ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: SendBtn(
                            text: "Cadastrar",
                            onValidate: _validateForm,
                              onSend: () async {
                                final response = await _controller.addNewResearcher(context);
                                if (response == "email_already_exists") {
                                  _showModalBottomSheet(context);
                                }else if (response != "falha") {
                                  setState(() {
                                    _generatedPassword = response;
                                    _showPassword = true;
                                  });
                              }
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
                _controller.setRole(UserRole.admin, context);
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