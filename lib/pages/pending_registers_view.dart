import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/controller/pending_registers_controller.dart';
import 'package:tcc_ceclimar/models/register_response.dart';
import 'package:tcc_ceclimar/pages/register_view.dart';
import 'package:tcc_ceclimar/utils/placeholder_registers.dart';
import 'package:tcc_ceclimar/widgets/register_item.dart';
import '../widgets/page_header.dart';

class PendingRegistersView extends StatefulWidget {
  static const String routeName = '/pendingRegistersView'; 
  final Function(int) updateIndex;

  const PendingRegistersView({super.key, this.updateIndex = _defaultUpdateIndex});

  static void _defaultUpdateIndex(int index) {

  }

  @override
  State<PendingRegistersView> createState() => _PendingRegistersViewState();
}

class _PendingRegistersViewState extends State<PendingRegistersView> {
  final PendingRegistersController _pendingRegistersController = PendingRegistersController();
  List<RegisterResponse> registers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRegisters();
  }

  Future<void> fetchRegisters() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<RegisterResponse> fetchedRegisters = await _pendingRegistersController.getAllPendingRegisters();
      setState(() {
        registers = fetchedRegisters;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
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
            collapsedHeight: 80,
            expandedHeight: 80,
            backgroundColor: Colors.white,
            shadowColor: Color.fromARGB(0, 173, 145, 145),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: PageHeader(
                        text: "Registros pendentes",
                        icon: const Icon(Icons.arrow_back),
                        onTap: Navigator.of(context).pop,
                      ),
                    )
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
                      if (!isLoading && registers.isEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Nenhum registro pendente para avaliação no momento.",
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      else
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: 0, bottom: 100),
                            physics: AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: displayRegisters.length,
                            itemBuilder: (context, index) {
                              return RegisterItem(
                                isLoading: isLoading,
                                register: displayRegisters[index],
                                route: RegisterDetailPage.routeName,
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ]
            )
          )
        ],
      )
    );
  }
}