import 'package:flutter/material.dart';
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
      registers = [
        RegisterResponse(
          uid: '1',
          date: '20/10/2020',
          city: 'Xangri-lá',
          state: true,
          authorName: 'John Doe',
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Validado",
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          ),
          sampleState: 4,
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Pinguim-de-magalhaes',
            image: Image.asset('assets/images/logo.png'),
            badge: Image.asset('assets/images/logo.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
        RegisterResponse(
          uid: '2',
          date: '25/10/2020',
          city: 'Xangri-lá',
          state: false,
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Validado",
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          ),
          sampleState: 1,
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Foca',
            image: Image.asset('assets/images/logo.png'),
            badge: Image.asset('assets/images/logo.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
        RegisterResponse(
          uid: '3',
          date: '30/10/2020',
          city: 'Xangri-lá',
          state: true,
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Enviado",
          registerImage: Image.asset(
            'assets/images/pinguim.png',
            fit: BoxFit.cover
          ),
          sampleState: 3,
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Pinguim',
            image: Image.asset('assets/images/pinguim.png'),
            badge: Image.asset('assets/images/logo.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
        RegisterResponse(
          uid: '4',
          date: '20/10/2020',
          city: 'Xangri-lá',
          state: true,
          authorName: 'John Doe',
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Validado",
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          ),
          sampleState: 2,
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Golfinho',
            image: Image.asset('assets/images/logo.png'), //todo imagem de fauna local
            badge: Image.asset('assets/images/logo.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
        RegisterResponse(
          uid: '5',
          date: '25/10/2020',
          city: 'Xangri-lá',
          state: false,
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Validado",
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          ),
          sampleState: 5,
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Coruja-buraqueira',
            image: Image.asset('assets/images/logo.png'),
            badge: Image.asset('assets/images/logo.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
        RegisterResponse(
          uid: '6',
          date: '30/10/2020',
          city: 'Xangri-lá',
          state: true,
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Enviado",
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          ),
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Albatroz',
            image: Image.asset('assets/images/logo.png'),
            badge: Image.asset('assets/images/logo.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
        RegisterResponse(
          uid: '7',
          date: '20/10/2020',
          city: 'Xangri-lá',
          state: true,
          authorName: 'John Doe',
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Validado",
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          ),
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Lobo-marinho',
            image: Image.asset('assets/images/logo.png'),
            badge: Image.asset('assets/images/logo.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
        RegisterResponse(
          uid: '8',
          date: '25/10/2020',
          city: 'Xangri-lá',
          state: false,
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Enviado",
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          ),
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Quero-quero',
            image: Image.asset('assets/images/logo.png'),
            badge: Image.asset('assets/images/logo.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
        RegisterResponse(
          uid: '9',
          date: '30/10/2020',
          city: 'Xangri-lá',
          state: true,
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Validado",
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          ),
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Tuim-de-asa-branca',
            image: Image.asset('assets/images/logo.png'),
            badge: Image.asset('assets/images/logo.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
        RegisterResponse(
          uid: '10',
          date: '20/10/2020',
          city: 'Xangri-lá',
          state: true,
          authorName: 'John Doe',
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Enviado",
          registerImage: Image.asset(
            'assets/images/tartaruga.png',
            fit: BoxFit.cover
          ),
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Tartaruga verde',
            image: Image.asset('assets/images/tartaruga.png'),
            badge: Image.asset('assets/images/logo.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
        RegisterResponse(
          uid: '11',
          date: '25/10/2020',
          city: 'Xangri-lá',
          state: false,
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Validado",
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          ),
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Pinguim-de-magalhaes',
            image: Image.asset('assets/images/logo.png'),
            badge: Image.asset('assets/images/logo.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
        RegisterResponse(
          uid: '12',
          date: '30/10/2020',
          city: 'Xangri-lá',
          state: true,
          location: const GeoPoint(-30.0345, -50.6452),
          status: "Validado",
          registerImage: Image.asset(
            'assets/images/tartaruga.png',
            fit: BoxFit.cover
          ),
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Lobo-marinho',
            image: Image.asset('assets/images/tartaruga.png'),
            badge: Image.asset('assets/images/loboMarinhoBadge.png'),
            species: 'Spheniscus magellanicus'
          )
        ),
      ];
      isLoading = false;
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
                    onTap: () => _filterRegisters("Validado"),
                    child: 
                      StatusLabel(
                        status: "Validado"
                      )
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () => _filterRegisters("Enviado"),
                    child: 
                      StatusLabel(
                        status: "Enviado"
                      )
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
  
  _filterRegisters(String status) {
    print(status);
  }
}