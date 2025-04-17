import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tcc_ceclimar/controller/auth_user_controller.dart';
import 'package:tcc_ceclimar/controller/my_profile_controller.dart';
import 'package:tcc_ceclimar/models/animal_response.dart';
import 'package:tcc_ceclimar/models/register_response.dart';
import 'package:tcc_ceclimar/pages/edit_profile.dart';
import 'package:tcc_ceclimar/pages/register_view.dart';
import 'package:tcc_ceclimar/utils/placeholder_registers.dart';
import 'package:tcc_ceclimar/widgets/badge_item.dart';
import 'package:tcc_ceclimar/widgets/login_header.dart';
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
  Map<dynamic, dynamic> animalCounters = {};
  ImageProvider image = AssetImage('assets/images/imageProfile.png');

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
  }

  Future<void> _loadUserImage() async {
    User? user = _controller.getCurrentUser();
    if (user != null) {
      String? profileImageUrl = await _controller.getProfileImageUrl(user.uid);
      if (profileImageUrl != null && profileImageUrl.isNotEmpty && mounted) {
        setState(() {
          image = NetworkImage(profileImageUrl);
        });
      }
    }
  }

  Future<void> _checkUserStatus() async {
    User? user = _controller.getCurrentUser();
    if (user == null) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
    } else {
      _loadUserImage();
      fetchRegisters();
      fetchAnimalCounters();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkUserStatus();
  }
  
  Future<void> fetchRegisters() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    List<RegisterResponse> fetchedRegisters = await _myProfileController.getRegisters();
    if (mounted){ 
      setState(() {
        registers = fetchedRegisters;
        isLoading = false;
      });
    }    
  }

  Future<void> fetchAnimalCounters() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    Map<dynamic, dynamic> fetchedAnimalCounters = await _myProfileController.getAnimalsCounters();
    if (mounted){ 
      setState(() {
        animalCounters = fetchedAnimalCounters;
        isLoading = false;
      });
    }    
  }

  @override
  Widget build(BuildContext context) {
    UserResponse? userData = _controller.getUserInfo();
    
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            collapsedHeight: 250,
            expandedHeight: 250,
            backgroundColor: Colors.white,
            shadowColor: Color.fromARGB(0, 173, 145, 145),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                  color: Colors.white,
                  child: Stack(
                  children: [
                    LoginHeaderWidget(imageFuture: Future.value(image)),
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
                          Visibility(
                            visible: userData?.name != null,
                            child: RichText(
                              text: TextSpan(
                              text: '${userData?.name}',
                              style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(PhosphorIcons.pencilSimple(PhosphorIconsStyle.regular), size: 20),
                        ],
                      ),
                    ),
                    SizedBox(height: 9),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [                    
                        RichText(
                          text: TextSpan(
                          text: "Registros realizados: ",
                          style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        isLoading
                          ? const Skeletonizer(
                            enabled: true, 
                            child: Text("XX", style: TextStyle(fontSize: 16)),
                          ) 
                          : RichText(
                            text: TextSpan(
                            text: "${registers.length}",
                            style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ProfileSwitch(
                        size: 600,
                        isUltimosRegistrosNotifier: isUltimosRegistrosNotifier
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: isUltimosRegistrosNotifier,
                  builder: (context, isUltimosRegistros, child) {
                    return !isUltimosRegistros
                            ? UltimosRegistrosContent(registers: registers, isLoading: isLoading)
                            : AnimaisEncontradosContent(counters: animalCounters, isLoading: isLoading);
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
            Visibility(
              visible: !_controller.isUserLogedWithGoogle(),
              child: TextButton(
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
  final bool isLoading;
  const UltimosRegistrosContent({super.key, required this.registers, required this.isLoading});
  @override
  Widget build(BuildContext context) {
    if (!isLoading && registers.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "Nenhum registro encontrado",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    }
    final limitedRegisters = registers.take(10).toList();
    final placeholderRegisters = generatePlaceholderRegisters(6);
    final displayRegisters = isLoading ? placeholderRegisters : limitedRegisters;

    return SizedBox(
      height: 340,
      child: Skeletonizer(
        enabled: isLoading,
        child: ListView.builder(
          padding: EdgeInsets.only(top: 0, bottom: 70),
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: displayRegisters.length,
          itemBuilder: (context, index) {
            return RegisterItem(
              isLoading: isLoading,
              register: displayRegisters[index],
              route: RegisterDetailPage.routeName  
            );
          },
        ),
      ),
    );
  }
}

class AnimaisEncontradosContent extends StatelessWidget {
  final Map<dynamic, dynamic> counters;
  final bool isLoading;
  const AnimaisEncontradosContent({super.key, required this.counters, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    final placeholderCounters = generatePlaceholderRegisters(3);

    return SizedBox(
      height: 340,
      child: Skeletonizer(
        enabled: isLoading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                "Seja um cientista cidadão! Contribua e junte as medalhas com seus registro validados",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(width: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(height: 10),
                    BadgeItem(
                      classe: "Aves",
                      image: Image.asset("assets/images/gaivotaBadge.png"),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Aves",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(counters['birdsFound'] != null ? "${counters['birdsFound']}" : "0")
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 10),
                    BadgeItem(
                      classe: "Mamíferos",
                      image: Image.asset("assets/images/gaivotaBadge.png"),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Mamíferos",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(counters['mammalsFound'] != null ? "${counters['mammalsFound']}" : "0")
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 10),
                    BadgeItem(
                      classe: "Répteis",
                      image: Image.asset("assets/images/gaivotaBadge.png"),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Répteis",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(counters['reptilesFound'] != null ? "${counters['reptilesFound']}" : "0")
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}