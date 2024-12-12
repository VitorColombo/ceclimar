import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/controller/auth_user_controller.dart';
import 'package:tcc_ceclimar/widgets/image_selector.dart';
import 'package:tcc_ceclimar/widgets/input_field.dart';
import 'package:tcc_ceclimar/widgets/page_header.dart';
import 'package:tcc_ceclimar/widgets/password_input.dart';
import 'package:tcc_ceclimar/widgets/send_btn.dart';

class EditProfile extends StatefulWidget {
  static const String routeName = '/editProfile';

  const EditProfile({super.key});
  
  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  final AuthenticationController _controller = AuthenticationController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.emailController.dispose();
    _controller.nameController.dispose();
    _controller.passController.dispose();
    _controller.passConfController.dispose();
    _controller.checkPassController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    setState(() {
      _controller.validateEditUserForm();
    });
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    User? user = _controller.getCurrentUser();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PageHeader(
              text: "Editar perfil",
              icon: const Icon(Icons.arrow_back),
              onTap: () => Navigator.pop(context),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ImageSelector(onImageSelected: _controller.setImage),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            user?.displayName ?? "",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            user?.email ?? "",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          InputField(
                            text: "Nome (Opcional)",
                            controller: _controller.nameController,
                            validator: (value) => _controller.nameError
                          ),
                          const SizedBox(height: 16),
                          InputField(
                            text: "E-mail (Opcional)",
                            controller: _controller.emailController,
                            validator: (value) => _controller.emailError
                          ),
                          const SizedBox(height: 16),
                          PasswordInput(
                            text: "Nova senha (Opcional)",
                            controller: _controller.passController, 
                            validator: (value) => _controller.passError
                          ),
                          const SizedBox(height: 16),
                          PasswordInput(
                            text: "Confirme a nova senha (Opcional)", 
                            controller: _controller.passConfController, 
                            validator: (value) => _controller.passConfError
                          ),
                          const SizedBox(height: 16),
                          PasswordInput(
                            text: "Senha atual",
                            controller: _controller.checkPassController, 
                            validator: (value) => _controller.checkPassError
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: SendBtn(
                              text: "Confirmar edição",
                              onValidate: _validateForm,
                              onSend: () async =>  {
                                if (_validateForm()) {
                                  if((await _controller.updateUserProfile(_formKey.currentContext!, _controller.checkPassController.text) == false)){
                                    Navigator.pop(_formKey.currentContext!)
                                  },
                                },
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
    );
  }
}