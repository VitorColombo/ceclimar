import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/controller/auth_user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/page_header.dart';

class MyProfile extends StatelessWidget {
  static const String routeName = '/myprofile'; 
  final Function(int) updateIndex;
  final AuthenticationController _controller = AuthenticationController();

  MyProfile({super.key, this.updateIndex = _defaultUpdateIndex});
  
  static void _defaultUpdateIndex(int index) {}

  void _logout(BuildContext context) {
    _controller.signOutUser();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PageHeader(text: "Meu perfil", icon: const Icon(Icons.arrow_back), onTap: () => updateIndex(0)),
          FutureBuilder<User?>(
            future: Future.value(_controller.getCurrentUser()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('Erro ao carregar os dados do usuário');
              } else if (snapshot.hasData) {
                User? user = snapshot.data;
                return Column(
                  children: [
                    Text('Nome: ${user?.displayName ?? 'N/A'}'),
                    Text('Email: ${user?.email ?? 'N/A'}'),
                    ElevatedButton(
                      onPressed: () => _logout(context),
                      child: const Text('Logout'),
                    ),
                  ],
                );
              } else {
                return const Text('Nenhum usuário logado');
              }
            },
          ),
        ],
      ),
    );
  }
}