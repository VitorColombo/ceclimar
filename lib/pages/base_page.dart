import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/pages/about_us.dart';
import 'package:tcc_ceclimar/pages/new_technical_register.dart';
import '../widgets/new_register_floating_btn.dart';
import 'home.dart';
import 'my_registers.dart';
import 'new_simple_register.dart';
import 'my_profile.dart';
import 'register_pannel.dart';
import 'evaluate_register.dart';
import 'local_animals.dart';
import 'new_researcher_user.dart';

class BasePage extends StatefulWidget {
  static const String routeName = '/basePage'; 
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int selectedIndex = 0;
  void updateIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is int) {
        updateIndex(args);
      }
    });
  }

  List<Widget> get pages => [
    HomePage(updateIndex: updateIndex),
    MyRegisters(updateIndex: updateIndex),
    MyProfile(updateIndex: updateIndex),
    NewSimpleRegister(updateIndex: updateIndex),
    LocalAnimals(updateIndex: updateIndex),
    RegisterPannel(updateIndex: updateIndex),
    EvaluateRegister(updateIndex: updateIndex),
    NewResearcherPage(updateIndex: updateIndex),
    NewTechnicalRegister(updateIndex: updateIndex),
    AboutUs(updateIndex:updateIndex),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (selectedIndex != 0) {
          updateIndex(0);
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: pages[selectedIndex],
        bottomNavigationBar: bottomNavBar(context),
      ),
    );
  }

  Container bottomNavBar(BuildContext context) {
    return Container(
      height: 82,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  updateIndex(0);
                },
                icon: selectedIndex == 0
                    ? const Icon(
                        Icons.home_rounded,
                        color: Colors.black,
                        size: 25,
                      )
                    : const Icon(
                        Icons.home_outlined,
                        color: Colors.black,
                        size: 25,
                      ),
              ),
              GestureDetector(
                onTap: () {
                  updateIndex(0);
                },
                child: label("Início", 0)
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  updateIndex(1);
                },
                icon: selectedIndex == 1
                    ? const Icon(
                        Icons.view_list_outlined,
                        color: Colors.black,
                        size: 25,
                      )
                    : const Icon(
                        Icons.list,
                        color: Colors.black,
                        size: 25,
                      ),
              ),
              GestureDetector(
                onTap: () {
                  updateIndex(1);
                },
                child: label("Registros", 1)
              ),
            ],
          ),
          AddNewRegisterFloatingBtn(updateIndex: updateIndex),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  updateIndex(2);
                },
                icon: selectedIndex == 2
                    ? const Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 25,
                      )
                    : const Icon(
                        Icons.person_outline,
                        color: Colors.black,
                        size: 25,
                      ),
              ),
              GestureDetector(
                onTap: () {
                  updateIndex(2);
                },
                child: label("Perfil", 2)
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  updateIndex(9);
                },
                icon: selectedIndex == 9
                    ? const Icon(
                        Icons.info,
                        color: Colors.black,
                        size: 25,
                      )
                    : const Icon(
                        Icons.info_outlined,
                        color: Colors.black,
                        size: 25,
                      ),
              ),
              GestureDetector(
                onTap: () {
                  updateIndex(9);
                }, 
                child: label("Sobre", 9)
              ),
            ],
          ),
        ],
      ),
    );
  }

  label(String s, index) {
    return  Transform.translate(
      offset: const Offset(0, -10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Text(
          textAlign: TextAlign.center,
          s,
          style: TextStyle(
            fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
            color: Colors.black,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}