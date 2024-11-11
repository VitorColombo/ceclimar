import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/controller/my_registers_controller.dart';
import 'package:tcc_ceclimar/models/animal_response.dart';
import 'package:tcc_ceclimar/widgets/register_status_label.dart';
import '../models/register_response.dart';
import '../widgets/page_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/register_item.dart';

class MyRegisters extends StatefulWidget {
  static const String routeName = '/myregisters';
  final Function(int) updateIndex;

  const MyRegisters({super.key, this.updateIndex = _defaultUpdateIndex});

  static void _defaultUpdateIndex(int index) {

  }

  @override
  State<MyRegisters> createState() => _MyRegistersState();
}

class _MyRegistersState extends State<MyRegisters> {
  final _my_registers_controller = MyRegistersController();
  List<RegisterResponse> registers = [];
  bool isLoading = true;
  bool isFiltered = false;
  String selectedFilter = "Todos";
  Color selectedFilterColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    fetchMockedRegisters(selectedFilter);
  }

  Future<void> fetchMockedRegisters(String status) async { //todo remover mocks
    await Future.delayed(const Duration(milliseconds: 500)); 
    if (!mounted) return;
    setState(() {
      registers = _my_registers_controller.getRegisters();
      isLoading = false;
      if(status == selectedFilter){
        selectedFilter = "Todos";
        return;
      }
      if(status == "Todos"){ 
        return;
      }
      registers = registers.where((element) => element.status == status).toList();
      selectedFilter = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PageHeader(text: "Meus registros", icon: const Icon(Icons.arrow_back), onTap: () => widget.updateIndex(0)),
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 20.0, bottom: 10),
              child: Row(
                children: [
                  Text("Filtro", style: TextStyle(color: Colors.grey[500])),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () => {
                      fetchMockedRegisters("Validado")
                    },
                    child: StatusLabel(
                      status: "Validado",
                      borderColor: selectedFilter == "Validado"
                          ? Colors.blue
                          : Colors.transparent,
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () => {
                      fetchMockedRegisters("Enviado")
                    },
                    child: StatusLabel(
                      status: "Enviado",
                      borderColor: selectedFilter == "Enviado"
                          ? Colors.blue
                          : Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? Container(
                  padding: const EdgeInsets.only(top: 250),
                  alignment: Alignment.center,
                  child: const Center(
                      child: CircularProgressIndicator()
                    ),
                )
                : SizedBox(
                    height: MediaQuery.of(context).size.height - kToolbarHeight,
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 0, bottom: 180),
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: registers.length,
                      itemBuilder: (context, index) {
                        return RegisterItem(register: registers[index]);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}