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
  // Remoção de List<RegisterResponse> registers = [];
  // Remoção de bool isLoading = true;
  String selectedFilter = "Todos";

  // Não precisamos de initState ou fetchRegisters, pois o StreamBuilder 
  // fará o trabalho de carregamento e atualização.
  
  // ⭐️ Mantenha o fetchRegisters para fins de filtro e refresh manual (opcional)
  // Mas mude a implementação para usar o Stream.
  Future<void> fetchRegisters(String status) async {
    setState(() {
      selectedFilter = status;
    });
    // Forçar um refresh manual do StreamBuilder não é necessário.
    // O StreamBuilder reagirá à mudança do selectedFilter no filtro.
  }
  
  // ⭐️ Função de filtragem movida para dentro do StreamBuilder
  List<RegisterResponse> _filterRegisters(List<RegisterResponse> allRegisters) {
    if (selectedFilter == "Todos") {
      return allRegisters;
    }
    return allRegisters
        .where((element) => element.status == selectedFilter)
        .toList();
  }


  @override
  Widget build(BuildContext context) {
    final placeholderRegisters = generatePlaceholderRegisters(6);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            collapsedHeight: 115,
            expandedHeight: 115,
            backgroundColor: Colors.white,
            shadowColor: const Color.fromARGB(0, 173, 145, 145),
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
                            onTap: () => fetchRegisters(selectedFilter == "Validado" ? "Todos" : "Validado"),
                            child: StatusLabel(
                              status: "Validado",
                              borderColor: selectedFilter == "Validado"
                                  ? Colors.blue
                                  : Colors.transparent,
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () => fetchRegisters(selectedFilter == "Enviado" ? "Todos" : "Enviado"),
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
                  child: StreamBuilder<List<RegisterResponse>>(
                    stream: _myRegistersController.getRegistersStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Erro ao carregar dados: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData && snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height - 250,
                          child: Skeletonizer(
                            enabled: true,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(top: 0, bottom: 100),
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: placeholderRegisters.length,
                              itemExtent: 100,
                              itemBuilder: (context, index) {
                                return RegisterItem(
                                  register: placeholderRegisters[index],
                                  route: RegisterDetailPage.routeName,
                                  isLoading: true,
                                  onDeleted: () {},
                                );
                              },
                            ),
                          ),
                        );
                      }
                      final allRegisters = snapshot.data ?? [];
                      final filteredRegisters = _filterRegisters(allRegisters);
                      final displayRegisters = filteredRegisters;
                      final isLoading = snapshot.connectionState == ConnectionState.waiting;

                      if (displayRegisters.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "Nenhum registro encontrado.",
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }

                      return SizedBox(
                        height: MediaQuery.of(context).size.height - 250,
                        child: Skeletonizer(
                          enabled: isLoading && displayRegisters.isEmpty, 
                          child: ListView.builder(
                            padding: const EdgeInsets.only(top: 0, bottom: 100),
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: displayRegisters.length,
                            itemExtent: 100,
                            itemBuilder: (context, index) {
                              return RegisterItem(
                                register: displayRegisters[index],
                                route: RegisterDetailPage.routeName,
                                isLoading: isLoading,
                                onDeleted: () {
                                   fetchRegisters(selectedFilter);
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}