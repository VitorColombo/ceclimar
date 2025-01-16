import 'dart:async';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tcc_ceclimar/utils/animals_service.dart';
import 'package:tcc_ceclimar/widgets/page_header.dart';
import '../models/animal_response.dart';
import '../widgets/send_btn.dart';

class RegisterPannel extends StatefulWidget {
  final Function(int) updateIndex;
  static const String routeName = '/registerPannel'; 
  static void _defaultUpdateIndex(int index) {}
  
  const RegisterPannel({super.key, this.updateIndex = _defaultUpdateIndex});
  
  @override
  _RegisterPannelState createState() => _RegisterPannelState();
}

class _RegisterPannelState extends State<RegisterPannel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AnimalService _animalService = AnimalService();
  late Future<List<AnimalResponse>> animalData;
  int? selectedIndex;
  late Map<String, double> dataMap = {};
  int totalRegisters = 00;

  @override
  void initState() {
    super.initState();
    animalData = _animalService.getAnimals().then((data) {
      for (AnimalResponse animal in data) {
        setState(() {
          totalRegisters += animal.quantity!;
        });  
      }
      data.sort((a, b) => b.quantity!.compareTo(a.quantity!));
      List<AnimalResponse> topTenAnimals = data.take(10).toList();
      dataMap = {for (var animal in topTenAnimals) animal.scientificName!: animal.quantity!.toDouble()};
      return topTenAnimals;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double chartSize = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: <Widget>[
              PageHeader(
                text: "Painel de registros",
                icon: const Icon(Icons.arrow_back),
                onTap: () => widget.updateIndex(0),
              ),
              Text("Total de registros: "),
              Skeletonizer(
                enabled: totalRegisters == 0,
                child: Text("${totalRegisters}")
                ),
              const Text("Registros avaliados: 123"),
              const Text("Registros pendentes: 111"),
              Transform(
                transform: Matrix4.translationValues(0.0, -120.0, 0.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: 300,
                  height: 800,
                  child: FutureBuilder<List<AnimalResponse>>(
                    future: animalData,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No data available');
                      } else {
                        return LayoutBuilder(
                          builder: (context, constraints) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: chartSize,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      PieChart(
                                        dataMap: dataMap,
                                        animationDuration: const Duration(milliseconds: 800),
                                        chartLegendSpacing: 32,
                                        chartRadius: chartSize * 0.8,
                                        chartValuesOptions: const ChartValuesOptions(
                                          decimalPlaces: 0,
                                          showChartValues: true,
                                        ),
                                        legendOptions: LegendOptions(
                                          legendPosition: LegendPosition.bottom,
                                          legendTextStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
                Transform(
                transform: Matrix4.translationValues(0.0, -120.0, 0.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                  SendBtn(
                    text: "Exportar Dados",
                    onValidate: () => true,
                    onSend: () {
                    },
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Icon(PhosphorIcons.export(), size: 30, color: Colors.white),
                  ),
                  ],
                ),
                ),
            ]
          ),
        ),
      ),
    );
  }
}