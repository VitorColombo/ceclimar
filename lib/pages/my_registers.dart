import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/controller/my_registers_controller.dart';
import 'package:tcc_ceclimar/pages/register_view.dart';
import 'package:tcc_ceclimar/widgets/register_status_label.dart';
import '../models/register_response.dart';
import '../widgets/page_header.dart';
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
  final MyRegistersController _myRegistersController = MyRegistersController();
  List<RegisterResponse> registers = [];
  bool isLoading = true;
  bool isFiltered = false;
  String selectedFilter = "Todos";
  Color selectedFilterColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    fetchRegisters(selectedFilter);
  }

  Future<void> fetchRegisters(String status) async {
    setState(() {
      isLoading = true;
    });
    try {
      List<RegisterResponse> fetchedRegisters = await _myRegistersController.getRegisters();
      if(mounted){
        setState(() {
          registers = fetchedRegisters;
          isLoading = false;
          if (status != "Todos") {
            registers = registers.where((element) => element.status == status).toList();
          }
          selectedFilter = status;
        });
      }
    } catch (e) {
      if(mounted){
        setState(() {
          isLoading = false;
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar registros: $e')),
      );
    }
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
                    onTap: () {
                      if (selectedFilter == "Validado") {
                        fetchRegisters("Todos");
                      } else {
                        fetchRegisters("Validado");
                      }
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
                    onTap: () {
                      if (selectedFilter == "Enviado") {
                        fetchRegisters("Todos");
                      } else {
                        fetchRegisters("Enviado");
                      }
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
                    child: CircularProgressIndicator(),
                  ),
                )
              : registers.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 250),
                      child: Center(
                        child: Text(
                          'Nenhum registro encontrado',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
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
                          return RegisterItem(
                            register: registers[index],
                            route: RegisterDetailPage.routeName,
                          );
                        },
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}
