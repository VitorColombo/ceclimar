import 'package:flutter/material.dart';
import 'modal_bottomsheet.dart';

class AddNewRegisterFloatingBtn extends StatelessWidget {
  final IconData icon; 
  final Color backgroundColor;
  final Color hoverColor; 
  final double size;
  final Function(int) updateIndex;

  const AddNewRegisterFloatingBtn({
    Key? key,
    this.icon = Icons.add,
    this.backgroundColor = const Color.fromARGB(255, 2, 52, 87),
    this.hoverColor = const Color.fromARGB(255, 31, 73, 95),
    this.size = 60,
    required this.updateIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -20),
      child: SizedBox(
        height: size,
        width: size,
        child: ElevatedButton(
          onPressed: () {
            showAddRegisterBottomSheet(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: const CircleBorder(),
            padding: EdgeInsets.zero,
            elevation: 0,
          ),
          child: Icon(icon, size: 50),
        ),
      ),
    );
  }

  void showAddRegisterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalBottomSheet(
          text: "Escolha o tipo de registro que deseja fazer",
          buttons: [
            TextButton(
              onPressed: () {
                updateIndex(3);
                Navigator.pop(context); 
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: const Color.fromARGB(255, 31, 73, 95), 
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
                "Registro simples",
                style: TextStyle(color: Colors.white), 
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                updateIndex(8);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: const Color.fromARGB(255, 31, 73, 95), 
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
                "Registro técnico",
                style: TextStyle(color: Colors.white), 
              ),
            ),
          ],
        );
      },
    );
  }
}