import 'package:flutter/material.dart';

class ProfileSwitch extends StatefulWidget {
  final double size;
  const ProfileSwitch({super.key, required this.size});
  
  @override
  State<ProfileSwitch> createState() => _ProfileSwitchState();
}

class _ProfileSwitchState extends State<ProfileSwitch> {
  bool foundAnimalsChecked = false;
  bool lastRegistersChecked = true;

  @override
  Widget build(BuildContext context) {
    return
        Container(
          width: 360,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color.fromARGB(255, 232, 232, 232)),
          child: Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 2, left: 2, right: 2),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => {
                    setState(() {
                      lastRegistersChecked = false;
                      foundAnimalsChecked = true;
                    })
                  },
                  child: Container(
                    width: 170,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(30),
                        color: foundAnimalsChecked
                            ? Colors.white
                            : Color.fromARGB(255, 232, 232, 232)),
                    child: Center(
                        child: Text(
                      'Últimos registros',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: foundAnimalsChecked
                              ? Color.fromARGB(255, 0, 111, 130)
                              : Colors.white),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () => {
                    setState(() {
                      lastRegistersChecked = true;
                      foundAnimalsChecked = false;
                    })
                  },
                  child: Container(
                    width: 180,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(30),
                        color: foundAnimalsChecked
                            ? Color.fromARGB(255, 232, 232, 232)
                            : Colors.white),
                    child: Center(
                        child: Text(
                      'Animais encontrados',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: foundAnimalsChecked
                              ? Color.fromARGB(255, 189, 189, 189)
                              : Color.fromARGB(255, 0, 111, 130)),
                    )),
                  ),
                ),
              ],
            ),
          ),
        );
  }
}