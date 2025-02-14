import 'dart:async';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tcc_ceclimar/controller/register_pannel_controller.dart';
import 'package:tcc_ceclimar/utils/animals_service.dart';
import 'package:tcc_ceclimar/widgets/page_header.dart';
import 'package:tcc_ceclimar/widgets/search_input_field.dart';
import '../models/animal_response.dart';
import '../widgets/send_btn.dart';
import '../models/register_response.dart';

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
  final RegisterPannelController _registerController = RegisterPannelController();
  late Future<List<AnimalResponse>> animalData;
  late List<String> speciesList = [];
  int? selectedIndex;
  late Map<String, double> dataMap = {};
  int totalRegisters = 0;
  int evaluatedRegisters = 0;
  int pendingRegisters = 0;
  DateTime? initDate;
  DateTime? endDate;
  final _monthDayFormat = DateFormat('dd-MM-yyyy');
  final TextEditingController initDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController speciesController = TextEditingController();
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  late Future<List<RegisterResponse>> registerData;
  final FocusNode focusNode = FocusNode();
  List<RegisterResponse> speciesRegisters = [];
  bool showSpeciesRegisters = false;

  @override
  void initState() {
    super.initState();
    endDate = DateTime.now();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    animalData = _animalService.getAnimals().then((data) {
      for (AnimalResponse animal in data) {
        setState(() {
          totalRegisters += animal.quantity!;
          speciesList = data.map((e) => e.scientificName!).toList();
        });
      }

      data.sort((a, b) => b.quantity!.compareTo(a.quantity!));
      List<AnimalResponse> topTenAnimals = data.take(10).toList();
      dataMap = {
        for (var animal in topTenAnimals)
          animal.scientificName!: animal.quantity!.toDouble()
      };
      return topTenAnimals;
    });
    _updateRegisterCount();
    totalRegisters += pendingRegisters;
  }

  Future<void> _updateRegisterCount() async {
      List<RegisterResponse> allRegisters = await _registerController.getAllRegisters();
      setState(() {
        evaluatedRegisters = allRegisters.where((reg) => reg.status == "Validado").length;
        pendingRegisters = allRegisters.where((reg) => reg.status == "Enviado").length;
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
              expandedTitleScale: 20,
              background: Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: PageHeader(
                        text: "Painel de registros",
                        icon: const Icon(Icons.arrow_back),
                        onTap: () => widget.updateIndex(0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Skeletonizer(
                      enabled: totalRegisters == 0,
                      child: Text("${totalRegisters}",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromRGBO(71, 169, 218, 1),
                          )),
                    ),
                    Text(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(71, 169, 218, 1),
                      ),
                      "Registros Cadastrados",
                    ),
                    Divider(
                        height: 40, thickness: 1.2, color: Colors.grey[200]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Skeletonizer(
                              enabled: totalRegisters == 0,
                              child: Text("$evaluatedRegisters",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        const Color.fromRGBO(71, 169, 218, 1),
                                  )),
                            ),
                            Text(
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromRGBO(71, 169, 218, 1),
                              ),
                              "Registros avaliados",
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Skeletonizer(
                              enabled: totalRegisters == 0,
                              child: Text("$pendingRegisters",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        const Color.fromRGBO(71, 169, 218, 1),
                                  )),
                            ),
                            Text(
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromRGBO(71, 169, 218, 1),
                              ),
                              "Registros pendentes",
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                        height: 40, thickness: 1.2, color: Colors.grey[200]),
                    Text(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 31, 73, 95),
                      ),
                      "Animais mais encontrados",
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: 300,
                      height: 560,
                      child: FutureBuilder<List<AnimalResponse>>(
                        future: animalData,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
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
                                            animationDuration:
                                                const Duration(milliseconds: 800),
                                            chartLegendSpacing: 32,
                                            chartRadius: chartSize * 0.8,
                                            chartValuesOptions:
                                                const ChartValuesOptions(
                                              decimalPlaces: 0,
                                              showChartValues: true,
                                            ),
                                            legendOptions: LegendOptions(
                                              legendPosition:
                                                  LegendPosition.bottom,
                                              legendTextStyle:
                                                  const TextStyle(
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
                    Divider(height: 40, thickness: 1.2, color: Colors.grey[200]),
                    Text(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 31, 73, 95),
                      ),
                      "Buscar dados por animal",
                    ),
                    Divider(height: 20),
                    SearchInputField(text: "Busca por espécie", controller: speciesController, items: speciesList, focusNode: focusNode, onChanged: _handleSpeciesSearch,),
                     Visibility(
                       visible: showSpeciesRegisters && speciesRegisters.isNotEmpty,
                       child: SizedBox(
                          height: 300,
                           child: ListView.builder(
                            itemCount: speciesRegisters.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text("${speciesRegisters[index].animal.scientificName} - ${speciesRegisters[index].date.toString().substring(0,10)}"),
                                subtitle: Text(speciesRegisters[index].status),
                              );
                            },
                        ),
                       ),
                     ),

                    Divider(height: 40, thickness: 1.2, color: Colors.grey[200]),
                    Text(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 31, 73, 95),
                      ),
                      "Buscar dados por período",
                    ),
                    Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 150,
                            child: TextField(
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            controller: initDateController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Data Inicial',
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: initDate ?? DateTime.now(),
                                firstDate: DateTime(2015, 8),
                                lastDate: DateTime.now(),
                                );
                                if (picked != null && picked != initDate) {
                                setState(() {
                                  initDate = picked;
                                  initDateController.text = dateFormat.format(picked);
                                });
                                }
                              },
                              ),
                            ),
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: initDate ?? DateTime.now(),
                              firstDate: DateTime(2015, 8),
                              lastDate: DateTime.now(),
                              );
                              if (picked != null && picked != initDate) {
                              setState(() {
                                initDate = picked;
                                initDateController.text = dateFormat.format(picked);
                              });
                              }
                            },
                            ),
                        ),                        
                        Container(
                          width: 150,
                          child: TextField(
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            controller: endDateController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Data Final',
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.calendar_today),
                                onPressed: () async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: endDate ?? DateTime.now(),
                                    firstDate: DateTime(2015, 8),
                                    lastDate: DateTime.now(),
                                  );
                                  if (picked != null && picked != endDate) {
                                    setState(() {
                                      endDate = picked;
                                      endDateController.text = dateFormat.format(picked);
                                    });
                                  }
                                },
                              ),
                            ),
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: initDate ?? DateTime.now(),
                              firstDate: DateTime(2015, 8),
                              lastDate: DateTime.now(),
                              );
                              if (picked != null && picked != initDate) {
                              setState(() {
                                initDate = picked;
                                initDateController.text = dateFormat.format(picked);
                              });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                     Visibility(
                      visible: initDate != null && endDate != null,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: 350,
                        height: 300,
                        child: FutureBuilder<List<RegisterResponse>>(
                          future: _fetchChartData(),
                          builder: (context, snapshot) {
                             if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return Center(child: const Text('Sem dados disponíveis para o período selecionado', textAlign: TextAlign.center,));
                              }else {
                              return Chart(
                                data: _generateChartData(snapshot.data!),
                                variables: {
                                  'Data': Variable(
                                    accessor: (RegisterSeriesQuantity datum) =>
                                        datum.date,
                                    scale: TimeScale(
                                      formatter: (time) => _monthDayFormat.format(time),
                                    ),
                                  ),
                                  'Registros': Variable(
                                    accessor: (RegisterSeriesQuantity datum) =>
                                        datum.quantity,
                                  ),
                                },
                                marks: [
                                  LineMark(
                                    shape: ShapeEncode(
                                        value: BasicLineShape(dash: [5, 2])
                                      ),
                                    selected: {'touchMove': {1}},
                                  )
                                ],
                                coord: RectCoord(color: Colors.white),
                                axes: [
                                  Defaults.horizontalAxis,
                                  Defaults.verticalAxis,
                                ],
                                selections: {
                                  'touchMove': PointSelection(
                                    on: {
                                      GestureType.scaleUpdate,
                                      GestureType.tapDown,
                                      GestureType.longPressMoveUpdate
                                    },
                                    dim: Dim.x,
                                  )
                                },
                                tooltip: TooltipGuide(
                                  followPointer: [false, true],
                                  align: Alignment.topLeft,
                                  offset: const Offset(-20, -20),
                                ),
                                crosshair: CrosshairGuide(
                                    followPointer: [false, true]
                                  ),
                              );
                             }
                          },
                        ),
                      ),
                    ),
                    Divider(height: 40, thickness: 1.2, color: Colors.grey[200]),
                    Stack(
                        alignment: Alignment.center,
                        children: [
                          SendBtn(
                            text: "Exportar Dados",
                            onValidate: () => true,
                            onSend: () {},
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: 
                              Icon(
                                PhosphorIcons.export(),
                                size: 30, color: Colors.white
                              ),
                          ),
                        ]),
                    Divider(height: 20),
                  ],
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  Future<List<RegisterResponse>> _fetchChartData() async{
    if (initDate != null && endDate != null) {
      List<RegisterResponse> registers =  await _registerController.getRegisterByDate(initDate!, endDate!);
      print(registers);
      return  registers;
    }
      return  [];
  }

  void _handleSpeciesSearch(String species) async {
    if (species.isEmpty) {
        setState(() {
            showSpeciesRegisters = false;
             speciesRegisters = [];
          });
         return;
    }
     List<RegisterResponse> registers = await _registerController.getRegisterBySpecies(species);
      setState(() {
        speciesRegisters = registers;
          showSpeciesRegisters = true;
    });
  }

  List<RegisterSeriesQuantity> _generateChartData(List<RegisterResponse> registersData) {
    
    Map<DateTime, int> registerCountsByDate = {};
    for (var register in registersData) {
       DateTime dateOnly = DateTime(register.date.year, register.date.month, register.date.day);
        registerCountsByDate[dateOnly] = (registerCountsByDate[dateOnly] ?? 0) + 1;
    }
     List<RegisterSeriesQuantity> chartData = registerCountsByDate.entries.map((entry) {
        return RegisterSeriesQuantity(entry.key, entry.value);
      }).toList();

    if(chartData.isEmpty){
        return  [
          RegisterSeriesQuantity(DateTime.now(), 0),
        ];
    }
    
    chartData.sort((a, b) => a.date.compareTo(b.date));
    return chartData;
  }
}

class RegisterSeriesQuantity {
  final DateTime date;
  final int quantity;

  RegisterSeriesQuantity(this.date, this.quantity);
}

