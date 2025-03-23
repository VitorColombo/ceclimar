import 'dart:async';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tcc_ceclimar/controller/register_pannel_controller.dart';
import 'package:tcc_ceclimar/pages/evaluated_registers.dart';
import 'package:tcc_ceclimar/pages/pending_registers.dart';
import 'package:tcc_ceclimar/pages/register_view.dart';
import 'package:tcc_ceclimar/utils/animals_service.dart';
import 'package:tcc_ceclimar/utils/map_screen.dart';
import 'package:tcc_ceclimar/widgets/page_header.dart';
import 'package:tcc_ceclimar/widgets/register_item.dart';
import 'package:tcc_ceclimar/widgets/search_input_field.dart';
import '../models/animal_response.dart';
import '../utils/table_manipulation.dart';
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
  List<RegisterResponse> registerData = [];
  final FocusNode focusNode = FocusNode();
  List<RegisterResponse> speciesRegisters = [];
  bool showSpeciesRegisters = false;
  bool isDateRangeLoading = false;
  bool isLoading = false;
  List<RegisterResponse> displayRegisters = [];
  Future<List<RegisterResponse>>? _registerDataFuture;


  @override
  void initState() {
    super.initState();
    endDate = DateTime.now();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    setState(() {
      isLoading = true;
    });
    try {
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
        return data;
      });

      await _updateRegisterCount();
      totalRegisters += pendingRegisters;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  Future<void> _updateRegisterCount() async {
    setState(() {
        isLoading = true;
      });
    try {
      List<RegisterResponse> allRegisters = await _registerController.getAllRegisters();
      setState(() {
        registerData = allRegisters;
        evaluatedRegisters = allRegisters.where((reg) => reg.status == "Validado").length;
        pendingRegisters = allRegisters.where((reg) => reg.status == "Enviado").length;
        displayRegisters = allRegisters;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void _unfocusTextField() {
    focusNode.unfocus();
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
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Skeletonizer(
                      enabled: isLoading,
                      child: Text("$totalRegisters",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(71, 169, 218, 1),
                        )
                      ),
                    ),
                    Text(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(71, 169, 218, 1),
                      ),
                      "Registros Cadastrados",
                    ),
                    Divider(height: 40, thickness: 1.2, color: Colors.grey[200]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, EvaluatedRegisters.routeName);
                          },
                          splashColor: Colors.blue.withOpacity(0.2),
                          highlightColor: Colors.blue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8.0),
                          child: Column(
                          children: [
                            Skeletonizer(
                            enabled: isLoading,
                            child: Text("$evaluatedRegisters",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color:
                                  const Color.fromRGBO(71, 169, 218, 1),
                              )),
                            ),
                            Row(
                              children:[
                                Text(
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromRGBO(71, 169, 218, 1),
                                  ),
                                  "Registros avaliados",
                                ),
                                PhosphorIcon(
                                  PhosphorIcons.arrowSquareIn(),
                                  color: const Color.fromRGBO(71, 169, 218, 1),
                                  size: 18,
                                ),
                              ]
                            ),
                          ],
                          )
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, PendingRegisters.routeName);
                          },
                          splashColor: Colors.blue.withOpacity(0.2),
                          highlightColor: Colors.blue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8.0),
                            child: Column(
                            children: [
                              Skeletonizer(
                                enabled: isLoading,
                                child: Text(
                                  "$pendingRegisters",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        const Color.fromRGBO(71, 169, 218, 1),
                                  )
                                ),
                              ),
                              Row(
                                children:[
                                  Text(
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromRGBO(71, 169, 218, 1),
                                    ),
                                    "Registros pendentes",
                                  ),
                                  PhosphorIcon(
                                    PhosphorIcons.arrowSquareIn(),
                                    color: const Color.fromRGBO(71, 169, 218, 1),
                                    size: 18,
                                  ),
                                ]
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider(height: 40, thickness: 1.2, color: Colors.grey[200]),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SearchInputField(
                        text: "Busca por espécie",
                        controller: speciesController,
                        items: speciesList,
                        focusNode: focusNode,
                        onChanged: _handleSpeciesSearch,
                      ),
                    ),
                    SizedBox(height: 10),
                    Visibility(
                      visible: showSpeciesRegisters && speciesRegisters.isNotEmpty,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height - 500,
                        child: Skeletonizer(
                          enabled: isLoading,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(top: 0, bottom: 10),
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: speciesRegisters.length,
                            itemBuilder: (context, index) {
                              return RegisterItem(
                                register: speciesRegisters[index],
                                route: RegisterDetailPage.routeName,
                                isLoading: isLoading,
                              );
                            },
                          ),
                        ),
                      )
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
                        SizedBox(
                          width: 150,
                          child: InkWell(
                            onTap: () => _selectDate(context, true),
                            child: IgnorePointer(
                              child: TextField(
                                style: TextStyle(color: Colors.black, fontSize: 14),
                                controller: initDateController,
                                decoration: InputDecoration(
                                  labelText: 'Data Inicial',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: InkWell(
                            onTap: () => _selectDate(context, false),
                            child: IgnorePointer(
                              child: TextField(
                                style: TextStyle(color: Colors.black, fontSize: 14),
                                controller: endDateController,
                                decoration: InputDecoration(
                                  labelText: 'Data Final',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                              ),
                            ),
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
                          future: (initDate != null && endDate != null)
                              ? (_registerDataFuture ??
                                  Future.value([]))
                              : Future.value([]),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Center(child: const Text('Sem dados disponíveis para o período selecionado', textAlign: TextAlign.center,));
                            } else {
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
                                  IntervalMark(
                                    color: ColorEncode(value: Color(0xFF4c88ff)),
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
                            SizedBox(
                              width: 260,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: const Color.fromRGBO(71, 169, 218, 1),
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
                                onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return TableManipulationBottomSheet(data: registerData);
                                  },
                                );
                              },
                              child: Text('Exportar dados', style: TextStyle(color: Colors.white)),
                              ),
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
                        ]
                    ),
                    Divider(height: 20),
                    Text("Ainda to trabalhando nessa tela!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
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

  Future<List<RegisterResponse>> _fetchChartData() async {
    if (initDate == null || endDate == null) {
      return [];
    }

    if (isDateRangeLoading) {
        return _registerDataFuture ?? Future.value([]);
    }

    setState(() {
      isDateRangeLoading = true;
    });
    try {
      DateTime initialDateTime = DateTime(initDate!.year, initDate!.month, initDate!.day, 0, 0, 0);
      DateTime endDateTime = DateTime(endDate!.year, endDate!.month, endDate!.day, 23, 59, 59);
      List<RegisterResponse> registers = await _registerController.getRegisterByDate(initialDateTime, endDateTime);
      return registers;
    } finally {
      setState(() {
        isDateRangeLoading = false;
      });
    }
  }


  void _handleSpeciesSearch(String species) async {
    setState(() {
      isLoading = true;
    });
    try {
      if (species.isEmpty) {
        setState(() {
          showSpeciesRegisters = false;
          speciesRegisters = [];
          displayRegisters = [];
        });
        return;
      }
      List<RegisterResponse> registers = await _registerController.getRegisterBySpecies(species);
      setState(() {
        speciesRegisters = registers;
        displayRegisters = registers;
        showSpeciesRegisters = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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

    if (chartData.isEmpty) {
      return [
        RegisterSeriesQuantity(DateTime.now(), 0),
      ];
    }
    chartData.sort((a, b) => a.date.compareTo(b.date));
    return chartData;
  }

   Future<void> _selectDate(BuildContext context, bool isInitDate) async {
    _unfocusTextField();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isInitDate ? (initDate ?? DateTime.now()) : (endDate ?? DateTime.now()),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isInitDate) {
          initDate = picked;
          initDateController.text = dateFormat.format(picked);
        } else {
          endDate = picked;
          endDateController.text = dateFormat.format(picked);
        }
        if (initDate != null && endDate != null) {
           _registerDataFuture = _fetchChartData();
        }
      });
    }
  }
}

class RegisterSeriesQuantity {
  final DateTime date;
  final int quantity;

  RegisterSeriesQuantity(this.date, this.quantity);
}