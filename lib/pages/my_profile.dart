import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/controller/auth_user_controller.dart';
import 'package:tcc_ceclimar/models/animal_response.dart';
import 'package:tcc_ceclimar/models/register_response.dart';
import 'package:tcc_ceclimar/widgets/badge_item.dart';
import 'package:tcc_ceclimar/widgets/header_banner_widget.dart';
import 'package:tcc_ceclimar/widgets/register_item.dart';
import '../models/user_data.dart';
import '../widgets/page_header.dart';
import '../widgets/profile_switch.dart';

class MyProfile extends StatefulWidget {
  static const String routeName = '/myprofile'; 
  final Function(int) updateIndex;

  const MyProfile({super.key, this.updateIndex = _defaultUpdateIndex,});
  
  static void _defaultUpdateIndex(int index) {}

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final AuthenticationController _controller = AuthenticationController();
  final ValueNotifier<bool> isUltimosRegistrosNotifier = ValueNotifier<bool>(false);
  bool isLoading = true;
  List<RegisterResponse> registers = [];
  List<AnimalResponse> animals = [];

  void _logout(BuildContext context) {
    _controller.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

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
            'assets/images/logo.png',
            fit: BoxFit.cover
          ),
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Pinguim',
            image: Image.asset('assets/images/logo.png'),
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
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Golfinho',
            image: Image.asset('assets/images/logo.png'),
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
            'assets/images/logo.png',
            fit: BoxFit.cover
          ),
          animal: AnimalResponse(
            uid: '1',
            popularName: 'Tartaruga verde',
            image: Image.asset('assets/images/logo.png'),
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
      ];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserResponse? userData = _controller.getUserInfo();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            collapsedHeight: 280,
            expandedHeight: 280,
            backgroundColor: Colors.white,
            shadowColor: Color.fromARGB(0, 173, 145, 145),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  HeaderBannerWidget(image: _controller.getUserImage()),
                  PageHeader(
                    text: "Meu perfil",
                    icon: const Icon(Icons.arrow_back, color: Colors.white,),
                    onTap: () => widget.updateIndex(0),
                    color: Colors.white,
                  ),
                  Positioned(
                    top: 55,
                    right: 16,
                    child: TextButton(
                      onPressed: () => _logout(context),
                      child: const Text("Logout", style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  children: [
                    Text(
                      '${userData?.name}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 9),
                    Text(
                      "Registros realizados: ${registers.length}", //todo integração
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 20),
                    ProfileSwitch(
                        size: 600,
                        isUltimosRegistrosNotifier: isUltimosRegistrosNotifier),
                    SizedBox(height: 10),
                  ],
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: isUltimosRegistrosNotifier,
                  builder: (context, isUltimosRegistros, child) {
                    return isLoading
                        ? Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: const LinearProgressIndicator(
                                color: Color.fromRGBO(71, 169, 218, 1), 
                                backgroundColor: Color.fromARGB(255, 31, 73, 95),
                                minHeight: 4,
                              ),
                          ),
                        )
                        : !isUltimosRegistros
                            ? UltimosRegistrosContent(registers: registers)
                            : AnimaisEncontradosContent(registers: registers);
                  },
                ),
              ]
            )
          )
        ]
      )
    );
  }
}

class UltimosRegistrosContent extends StatelessWidget {
  final List<RegisterResponse> registers;

  const UltimosRegistrosContent({super.key, required this.registers});
  @override
  Widget build(BuildContext context) {
    final limitedRegisters = registers.take(10).toList();

    return SizedBox(
      height: 400,
      child: ListView.builder(
        padding: EdgeInsets.only(top: 0, bottom: 70),
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: limitedRegisters.length,
        itemBuilder: (context, index) {
          return RegisterItem(register: limitedRegisters[index]);
        },
      ),
    );
  }
}

class AnimaisEncontradosContent extends StatelessWidget {
  final List<dynamic> registers;

  const AnimaisEncontradosContent({super.key, required this.registers});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: GridView.builder(
        padding: EdgeInsets.only(top: 0, bottom: 70, left: 1, right: 1),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 9,
          mainAxisSpacing: 1,
        ),
        itemCount: registers.length,
        itemBuilder: (context, index) {
          return BadgeItem(register: registers[index]);
        },
      ),
    );
  }
}