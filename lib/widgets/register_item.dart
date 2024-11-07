import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/pages/register_view.dart';
import '../models/register_response.dart';

class RegisterItem extends StatelessWidget {
  final RegisterResponse register;

  const RegisterItem({super.key, required this.register});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4),
          child: GestureDetector(
            onTap: () {
                Navigator.pushNamed(
                context,
                RegisterDetailPage.routeName,
                arguments: register,
                );
            },
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Colors.transparent),
              ),
              child: ListTile(
                leading: SizedBox(
                  width: 64,
                  height: 64,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Align(
                      alignment: Alignment.center,
                      child: register.registerImage
                      ),
                  ),
                ),
                title: Row(
                  children: [
                    Text(
                      register.animal.popularName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    Baseline(
                      baseline: 14,
                      baselineType: TextBaseline.alphabetic,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: register.status == "Validado" ? Color.fromARGB(255, 178, 227, 170) : Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.location_pin, color: Colors.black, size: 20),
                        SizedBox(width: 6),
                        Text(register.city),
                      ],
                    ), 
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.date_range_outlined, color: Colors.black, size: 20),
                        SizedBox(width: 6),
                        Text(register.date),
                      ],
                    ), 
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
        ),
        Divider(
          height: 0,
          thickness: 1,
          indent: 20,
          endIndent: 20,
          color: Colors.grey[300],
        ),
      ],
    );
  }
}