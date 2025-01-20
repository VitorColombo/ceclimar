import 'package:flutter/material.dart';

class ProfileSwitch extends StatefulWidget {
  final double size;
  final ValueNotifier<bool> isUltimosRegistrosNotifier;

  const ProfileSwitch({super.key, required this.size, required this.isUltimosRegistrosNotifier});
  
  @override
  State<ProfileSwitch> createState() => _ProfileSwitchState();
}

class _ProfileSwitchState extends State<ProfileSwitch> {
  bool get foundAnimalsChecked => !widget.isUltimosRegistrosNotifier.value;
  bool get lastRegistersChecked => widget.isUltimosRegistrosNotifier.value;
  set foundAnimalsChecked(bool value) => widget.isUltimosRegistrosNotifier.value = value;
  set lastRegistersChecked(bool value) => widget.isUltimosRegistrosNotifier.value = value;

  @override
  Widget build(BuildContext context) {
      double textSize = getResponsiveTextSize(context, 16.0);

    return
        ValueListenableBuilder<bool>(
          valueListenable: widget.isUltimosRegistrosNotifier,
          builder: (context, value, child) {
            return Container(
              width: 360,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromARGB(255, 232, 232, 232)
                ),
              child: Padding(
                padding: const EdgeInsets.only(top: 2, bottom: 2, left: 2, right: 2),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => {
                        setState(() {
                          lastRegistersChecked = true;
                          foundAnimalsChecked = false;
                          widget.isUltimosRegistrosNotifier.value = lastRegistersChecked;
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
                                : Color.fromARGB(255, 232, 232, 232)
                              ),
                        child: Center(
                            child: Text(
                          'Últimos registros',
                          style: TextStyle(
                              fontSize: textSize - 2,
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
                          lastRegistersChecked = false;
                          foundAnimalsChecked = true;
                          widget.isUltimosRegistrosNotifier.value = lastRegistersChecked;
                        })
                      },
                      child: Container(
                        width: 180,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(30),
                            color: lastRegistersChecked
                                ? Colors.white
                                : Color.fromARGB(255, 232, 232, 232)),
                        child: Center(
                            child: Text(
                          'Animais encontrados',
                          style: TextStyle(
                              fontSize: textSize - 2,
                              fontWeight: FontWeight.bold,
                              color: lastRegistersChecked
                                  ? Color.fromARGB(255, 0, 111, 130)
                                  : Color.fromARGB(255, 189, 189, 189)),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
          );
      },
   );
  }
}
double getResponsiveTextSize(BuildContext context, double baseSize) {
  double screenWidth = MediaQuery.of(context).size.width;
  return baseSize * (screenWidth / 375.0);
}