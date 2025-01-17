import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tcc_ceclimar/controller/my_registers_controller.dart';
import 'package:tcc_ceclimar/pages/register_view.dart';
import 'package:tcc_ceclimar/utils/placeholder_registers.dart';
import 'package:tcc_ceclimar/widgets/register_status_label.dart';
import '../models/register_response.dart';
import '../widgets/page_header.dart';
import '../widgets/register_item.dart';

class MyRegisters extends StatefulWidget {
  static const String routeName = '/myregisters';
  final Function(int) updateIndex;

  const MyRegisters({super.key, this.updateIndex = _defaultUpdateIndex});

  static void _defaultUpdateIndex(int index) {}

  @override
  State<MyRegisters> createState() => _MyRegistersState();
}

class _MyRegistersState extends State<MyRegisters> {
  final MyRegistersController _myRegistersController = MyRegistersController();
  List<RegisterResponse> registers = [];
  bool isLoading = true;
  bool isFiltered = false;
  String selectedFilter = "Todos";

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
      List<RegisterResponse> fetchedRegisters =
          await _myRegistersController.getRegisters();
      if (mounted) {
        setState(() {
          registers = fetchedRegisters;
          isLoading = false;
          if (status != "Todos") {
            registers =
                registers.where((element) => element.status == status).toList();
          }
          selectedFilter = status;
        });
      }
    } catch (e) {
      if (mounted) {
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
    final placeholderRegisters = generatePlaceholderRegisters(6);
    final displayRegisters = isLoading ? placeholderRegisters : registers;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            collapsedHeight: 115,
            expandedHeight: 115,
            backgroundColor: Colors.white,
            shadowColor: Color.fromARGB(0, 173, 145, 145),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    PageHeader(
                        text: "Meus registros",
                        icon: const Icon(Icons.arrow_back),
                        onTap: () => widget.updateIndex(0)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 110, left: 20.0, bottom: 10),
                      child: Row(
                        children: [
                          Icon(PhosphorIcons.funnel(), color: Colors.grey[500], size: 16),
                          Text("Filtrar:", style: TextStyle(color: Colors.grey[500])),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              fetchRegisters("Todos");
                            },
                            child: StatusLabel(
                              status: "Todos",
                              borderColor: selectedFilter == "Todos"
                                  ? Colors.blue
                                  : Colors.transparent,
                            ),
                          ),
                          const SizedBox(width: 10),
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
                          const SizedBox(width: 10),
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
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      !isLoading && registers.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Nenhum registro encontrado.",
                                  style: const TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height - kToolbarHeight,
                              child: Skeletonizer(
                                enabled: isLoading,
                                child: ListView.builder(
                                  padding: const EdgeInsets.only(top: 0, bottom: 200),
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: displayRegisters.length,
                                  itemBuilder: (context, index) {
                                    return RegisterItem(
                                      register: displayRegisters[index],
                                      route: RegisterDetailPage.routeName,
                                      isLoading: isLoading,
                                    );
                                  },
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ]
            )
          )
        ],
      ),
    );
  }
}