import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/models/user_data.dart';
import 'package:tcc_ceclimar/utils/user_role.dart';
import 'package:tcc_ceclimar/widgets/home_card.dart';
import 'package:tcc_ceclimar/widgets/page_header.dart';
import 'package:tcc_ceclimar/controller/auth_user_controller.dart';
import '../widgets/redirect_home_card.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  final Function(int) updateIndex;

  const HomePage({
    super.key,
    required this.updateIndex,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthenticationController authController = AuthenticationController();
  late Future<UserResponse> loggedUser;

  @override
  void initState() {
    loggedUser = authController.getLoggedUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PageHeader(text: "Menu inicial"),
          Expanded(
            child: FutureBuilder<UserResponse>(
              future: loggedUser,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final user = snapshot.data!;
                  return GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(16.0),
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    children: [
                      HomeCard(text: "Meus Registros", index: 1, updateIndex: widget.updateIndex, icon: Image.asset('assets/images/my_registers.png', height: 72, width: 72,)),
                      HomeCard(text: "Meu Perfil", index: 2, updateIndex: widget.updateIndex, icon: Image.asset('assets/images/profile.png', height: 72, width: 72,)),
                      HomeCard(text: "Novo Registro", index: 3, updateIndex: widget.updateIndex, icon: Image.asset('assets/images/new_register.png', height: 72, width: 72,)),
                      RedirectHomeCard(text: "Fauna Local", icon: Image.asset('assets/images/bird.png', height: 72, width: 72,), websiteUrl: "https://www.ufrgs.br/faunamarinhars/"),
                      HomeCard(text: "Painel de Registros", index: 5, updateIndex: widget.updateIndex, icon: Image.asset('assets/images/register_pannel.png', height: 72, width: 72,)),
                      if (user.role == UserRole.admin.roleString)
                        HomeCard(text: "Avaliar Registro", index: 6, updateIndex: widget.updateIndex, icon: Image.asset('assets/images/search.png', height: 72, width: 72,)),
                      if (user.role == UserRole.admin.roleString)
                        HomeCard(text: "Adicionar Pesquisador", index: 7, updateIndex: widget.updateIndex, icon: Image.asset('assets/images/add_researcher.png', height: 72, width: 72,)),
                    ],
                  );
                } else {
                  return GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(16.0),
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    children: [
                      HomeCard(text: "Meus Registros", index: 1, updateIndex: widget.updateIndex, icon: Image.asset('assets/images/my_registers.png', height: 72, width: 72,)),
                      HomeCard(text: "Meu Perfil", index: 2, updateIndex: widget.updateIndex, icon: Image.asset('assets/images/profile.png', height: 72, width: 72,)),
                      HomeCard(text: "Novo Registro", index: 3, updateIndex: widget.updateIndex, icon: Image.asset('assets/images/new_register.png', height: 72, width: 72,)),
                      HomeCard(text: "Fauna Local", index: 4, updateIndex: widget.updateIndex, icon: Image.asset('assets/images/bird.png', height: 72, width: 72,)),
                      HomeCard(text: "Painel de Registros", index: 5, updateIndex: widget.updateIndex, icon: Image.asset('assets/images/register_pannel.png', height: 72, width: 72,)),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}