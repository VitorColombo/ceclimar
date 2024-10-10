import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/widgets/new_register_floating_btn.dart';
import 'package:tcc_ceclimar/widgets/page_header.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';
  final Function(int) updateIndex;

  const HomePage({
    Key? key,
    required this.updateIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PageHeader(text: "Menu inicial"),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16.0),
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              children: [
                HomeCard(text: "Meus Registros", index: 1, updateIndex: updateIndex, icon: Image.asset('assets/images/my_registers.png', height: 72, width: 72,)),
                HomeCard(text: "Meu Perfil", index: 2, updateIndex: updateIndex, icon: Image.asset('assets/images/profile.png', height: 72, width: 72,)),
                HomeCard(text: "Novo Registro", index: 3, updateIndex: updateIndex, icon: Image.asset('assets/images/new_register.png', height: 72, width: 72,)),
                HomeCard(text: "Fauna Local", index: 4, updateIndex: updateIndex, icon: Image.asset('assets/images/bird.png', height: 72, width: 72,)),
                HomeCard(text: "Painel de Registros", index: 5, updateIndex: updateIndex, icon: Image.asset('assets/images/register_pannel.png', height: 72, width: 72,)),
                HomeCard(text: "Avaliar Registro", index: 6, updateIndex: updateIndex,icon: Image.asset('assets/images/search.png', height: 72, width: 72,)),
                HomeCard(text: "Adicionar Pesquisador", index: 7, updateIndex: updateIndex, icon: Image.asset('assets/images/add_researcher.png', height: 72, width: 72,)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final String text;
  final Widget icon;
  final int index;
  final Function(int) updateIndex;
  late final AddNewRegisterFloatingBtn addNewRegisterFloatingBtn;

  HomeCard({
    super.key,
    required this.text,
    required this.icon,
    required this.index,
    required this.updateIndex,
  }) {
    addNewRegisterFloatingBtn = AddNewRegisterFloatingBtn(updateIndex: updateIndex);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (text == "Novo Registro"){
          addNewRegisterFloatingBtn.showAddRegisterBottomSheet(context);
        }
        else{
          updateIndex(index);
        }
      },
      child: Card(
        shadowColor: Colors.black.withOpacity(0.7),
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color:  const Color.fromARGB(255, 71, 169, 218),
        child: Padding(
          padding: const EdgeInsets.only(top: 7.0, bottom: 5.0, left: 15.0, right: 15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 14.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: icon
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}