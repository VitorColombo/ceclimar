import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tcc_ceclimar/controller/auth_user_controller.dart';
import 'package:tcc_ceclimar/controller/my_profile_controller.dart';
import 'package:tcc_ceclimar/models/animal_response.dart';
import 'package:tcc_ceclimar/models/register_response.dart';
import 'package:tcc_ceclimar/pages/edit_profile.dart';
import 'package:tcc_ceclimar/pages/register_view.dart';
import 'package:tcc_ceclimar/widgets/badge_item.dart';
import 'package:tcc_ceclimar/widgets/header_banner_widget.dart';
import 'package:tcc_ceclimar/widgets/modal_bottomsheet.dart';
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
  final MyProfileController _myProfileController = MyProfileController();
  final ValueNotifier<bool> isUltimosRegistrosNotifier = ValueNotifier<bool>(false);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = true;
  List<RegisterResponse> registers = [];
  List<AnimalResponse> animals = [];
  ImageProvider? image;

  Future<void> _logout(BuildContext context) async {
    try {
      _controller.signOut(_scaffoldKey.currentContext!);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao sair: $e')));
    }
  }

  @override
  void initState() {
    super.initState();
    _checkUserStatus();
    fetchMockedRegisters();
  }

  Future<ImageProvider?> _loadUserImage() async {
    User? user = _controller.getCurrentUser();
    if (user != null) {
      try {
        String? profileImageUrl = await _controller.getProfileImageUrl(user.uid);
        if (profileImageUrl != null) {
          return NetworkImage(profileImageUrl);
        }
      } catch (e) {
        print("Error loading profile image: $e");
      }
    }
    return AssetImage('assets/images/imageProfile.png');
  }

  Future<void> _checkUserStatus() async {
    User? user = _controller.getCurrentUser();
    if (user == null) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
    } else {
      _loadUserImage();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkUserStatus();
  }
  
  Future<void> fetchMockedRegisters() async { //todo remover mocks
    await Future.delayed(const Duration(milliseconds: 500)); 
    if (!mounted) return;
    setState(() {
      registers = _myProfileController.getRegisters();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserResponse? userData = _controller.getUserInfo();
    
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            collapsedHeight: 250,
            expandedHeight: 250,
            backgroundColor: Colors.white,
            shadowColor: Color.fromARGB(0, 173, 145, 145),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  FutureBuilder<ImageProvider?>(
                    future: _loadUserImage(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        return HeaderBannerWidget(image: snapshot.data!);
                      } else {
                        return const HeaderBannerWidget(image: AssetImage('assets/images/imageProfile.png'));
                      }
                    },
                  ),
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
                    SizedBox(height: 9),
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () => showMyProfileBottomSheet(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${userData?.name}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(width: 8),
                          Icon(PhosphorIcons.pencilSimple(PhosphorIconsStyle.regular), size: 20),
                        ],
                      ),
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

  void showMyProfileBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalBottomSheet(
          text: "Escolha uma opção",
          buttons: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                    Navigator.pushNamed(context, EditProfile.routeName).then((_) {
                      _loadUserImage();
                    });
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: const Color.fromARGB(255, 31, 73, 95),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter"
                ),
                overlayColor: Colors.white,
              ),
              child: const Text(
                "Editar perfil",
                style: TextStyle(color: Colors.white), 
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                showWarningMessage();
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.red,
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
              child: const Text(
                "Excluir conta",
                style: TextStyle(color: Colors.white), 
              ),
            ),
          ],
        );
      },
    );
  }

  void showWarningMessage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Atenção"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Deseja realmente excluir sua conta?"),
              const SizedBox(height: 20),
              if (!_controller.isUserLogedWithGoogle())
                TextField(
                  controller: _controller.passController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                String password = _controller.passController.text.trim();
                  bool success = await _controller.deleteAccount(password, _scaffoldKey.currentContext!);
                  if (success) {
                    _logout(_scaffoldKey.currentContext!);
                  }
              },
              child: const Text("Excluir"),
            ),
          ],
        );
      },
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
          return RegisterItem(
            register: limitedRegisters[index],
            route: RegisterDetailPage.routeName  
          );
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