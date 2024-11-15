import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/controller/pending_registers_controller.dart';
import 'package:tcc_ceclimar/models/register_response.dart';
import 'package:tcc_ceclimar/pages/evaluate_register.dart';
import 'package:tcc_ceclimar/widgets/register_item.dart';
import '../widgets/page_header.dart';

class PendingRegisters extends StatefulWidget {
  static const String routeName = '/pendingRegisters'; 
  final Function(int) updateIndex;

  const PendingRegisters({super.key, this.updateIndex = _defaultUpdateIndex});

  static void _defaultUpdateIndex(int index) {

  }

  @override
  State<PendingRegisters> createState() => _PendingRegistersState();
}

class _PendingRegistersState extends State<PendingRegisters> {
  final PendingRegistersController _pendingRegistersController = PendingRegistersController();
  List<RegisterResponse> registers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMockedRegisters();
  }

  Future<void> fetchMockedRegisters() async { //todo remover mocks
    await Future.delayed(const Duration(milliseconds: 500)); 
    if (!mounted) return;
    setState(() {
      registers = _pendingRegistersController.getRegisters();
      isLoading = false;
      registers = registers.where((element) => element.status == "Enviado").toList(); //todo enviar o filtro pela controller para o backend
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PageHeader(
              text: "Registros pendentes",
              icon: const Icon(Icons.arrow_back), 
              onTap: () => widget.updateIndex(0)
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
                        return RegisterItem(
                          register: registers[index],
                          route: EvaluateRegister.routeName
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