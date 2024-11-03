import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/controller/auth_user_controller.dart';
import 'package:tcc_ceclimar/models/register_response.dart';
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
    await Future.delayed(const Duration(milliseconds: 2000)); 
    if (!mounted) return;
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
                      "Registros realizados: 123", //todo integração
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
                            : AnimaisEncontradosContent();
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('Baleia Jubarte'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Torres'),
              Text('Enviado em 20/10/2020'),
            ],
          ),
        ),
        ListTile(
          title: Text('Golfinho'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tramandaí'),
              Text('Enviado em 20/10/2020'),
            ],
          ),
        ),
      ],
    );
  }
}