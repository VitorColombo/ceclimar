import 'package:flutter/material.dart';
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
    await Future.delayed(const Duration(seconds: 1)); 
    setState(() {
      registers = [
        RegisterResponse(
          uid: '1',
          date: '20/10/2020',
          popularName: 'Lobo Marinho',
          city: 'Xangri-lá',
          state: true,
          authorName: 'John Doe',
          species: 'Otaria flavescens',
          location: const GeoPoint(-30.0345, -50.6452),
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          )
        ),
        RegisterResponse(
          uid: '2',
          date: '25/10/2020',
          popularName: 'Pinguim-de-magalhaes',
          city: 'Xangri-lá',
          state: false,
          species: 'Spheniscus magellanicus',
          location: const GeoPoint(-30.0345, -50.6452),
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          )
        ),
        RegisterResponse(
          uid: '3',
          date: '30/10/2020',
          popularName: 'Pinguim-de-magalhaes',
          city: 'Xangri-lá',
          state: true,
          species: 'Spheniscus magellanicus',
          location: const GeoPoint(-30.0345, -50.6452),
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          )
        ),
                RegisterResponse(
          uid: '1',
          date: '20/10/2020',
          popularName: 'Lobo Marinho',
          city: 'Xangri-lá',
          state: true,
          authorName: 'John Doe',
          species: 'Otaria flavescens',
          location: const GeoPoint(-30.0345, -50.6452),
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          )
        ),
        RegisterResponse(
          uid: '2',
          date: '25/10/2020',
          popularName: 'Pinguim-de-magalhaes',
          city: 'Xangri-lá',
          state: false,
          species: 'Spheniscus magellanicus',
          location: const GeoPoint(-30.0345, -50.6452),
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          )
        ),
        RegisterResponse(
          uid: '3',
          date: '30/10/2020',
          popularName: 'Pinguim-de-magalhaes',
          city: 'Xangri-lá',
          state: true,
          species: 'Spheniscus magellanicus',
          location: const GeoPoint(-30.0345, -50.6452),
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          )
        ),
                RegisterResponse(
          uid: '1',
          date: '20/10/2020',
          popularName: 'Lobo Marinho',
          city: 'Xangri-lá',
          state: true,
          authorName: 'John Doe',
          species: 'Otaria flavescens',
          location: const GeoPoint(-30.0345, -50.6452),
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          )
        ),
        RegisterResponse(
          uid: '2',
          date: '25/10/2020',
          popularName: 'Pinguim-de-magalhaes',
          city: 'Xangri-lá',
          state: false,
          species: 'Spheniscus magellanicus',
          location: const GeoPoint(-30.0345, -50.6452),
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          )
        ),
        RegisterResponse(
          uid: '3',
          date: '30/10/2020',
          popularName: 'Pinguim-de-magalhaes',
          city: 'Xangri-lá',
          state: true,
          species: 'Spheniscus magellanicus',
          location: const GeoPoint(-30.0345, -50.6452),
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          )
        ),
                RegisterResponse(
          uid: '1',
          date: '20/10/2020',
          popularName: 'Lobo Marinho',
          city: 'Xangri-lá',
          state: true,
          authorName: 'John Doe',
          species: 'Otaria flavescens',
          location: const GeoPoint(-30.0345, -50.6452),
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          )
        ),
        RegisterResponse(
          uid: '2',
          date: '25/10/2020',
          popularName: 'Pinguim-de-magalhaes',
          city: 'Xangri-lá',
          state: false,
          species: 'Spheniscus magellanicus',
          location: const GeoPoint(-30.0345, -50.6452),
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
          )
        ),
        RegisterResponse(
          uid: '3',
          date: '30/10/2020',
          popularName: 'Pinguim-de-magalhaes',
          city: 'Xangri-lá',
          state: true,
          species: 'Spheniscus magellanicus',
          location: const GeoPoint(-30.0345, -50.6452),
          registerImage: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover
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
            Container(
              height: MediaQuery.of(context).size.height - kToolbarHeight,
              child: ListView.builder(
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