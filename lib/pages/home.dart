import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc_ceclimar/models/user_data.dart';
import 'package:tcc_ceclimar/utils/user_role.dart';
import 'package:tcc_ceclimar/widgets/home_card.dart';
import 'package:tcc_ceclimar/widgets/page_header.dart';
import 'package:tcc_ceclimar/controller/auth_user_controller.dart';
import '../widgets/redirect_home_card.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  final Function(int) updateIndex;

  const HomePage({
    super.key,
    required this.updateIndex,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthenticationController authController = AuthenticationController();
  late Future<UserResponse> loggedUser;

  bool _showAdminCards = false;
  bool _adminAnimationTriggered = false;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _hasInternet = false;

  @override
  void initState() {
    super.initState();
    loggedUser = authController.getLoggedUserData();
    _showAdminCards = false;
    _adminAnimationTriggered = false;
    _initConnectivity();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await Connectivity().checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint('Could not check connectivity status: $e');
      if (mounted) {
        setState(() {
           _connectionStatus = ConnectivityResult.none;
           _hasInternet = false;
        });
      }
      return;
    }
    if (!mounted) {
      return;
    }
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (mounted) {
        setState(() {
          _connectionStatus = result;
          _hasInternet = (result == ConnectivityResult.mobile ||
                          result == ConnectivityResult.wifi ||
                          result == ConnectivityResult.ethernet ||
                          result == ConnectivityResult.vpn);
          if (!_hasInternet) {
              _showAdminCards = false;
              _adminAnimationTriggered = false;
          }
        });
    }
  }

  void _triggerAdminCardAnimation() {
    if (!_adminAnimationTriggered && mounted) {
      _adminAnimationTriggered = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _showAdminCards = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PageHeader(text: "Menu inicial"),
          Expanded(
            child: FutureBuilder<UserResponse>(
              future: loggedUser,
              builder: (context, userSnapshot) {
                if (userSnapshot.hasError) {
                  _showAdminCards = false;
                  _adminAnimationTriggered = false;
                  return Center(child: Text('Erro ao carregar os dados do usuário: ${userSnapshot.error}\nVerifique a conexão com a internet.'));
                } else if (userSnapshot.hasData) {
                  final user = userSnapshot.data!;
                  final bool isAdmin = user.role == UserRole.admin.roleString;
                  final bool shouldDisplayAdminFeatures = isAdmin && _hasInternet;
                  if (!shouldDisplayAdminFeatures) {
                    _showAdminCards = false;
                    _adminAnimationTriggered = false;
                  } else {
                    _triggerAdminCardAnimation();
                  }
                  const Duration animationDuration = Duration(milliseconds: 500);
                  const Curve animationCurve = Curves.easeIn;
                  return GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(16.0),
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    children: [
                      HomeCard(text: "Meus Registros", index: 1, updateIndex: widget.updateIndex, icon: Image.asset('assets/images/my_registers.png', height: 72, width: 72,)),
                      HomeCard(text: "Meu Perfil", index: 2, updateIndex: widget.updateIndex, icon: Image.asset('assets/images/profile.png', height: 72, width: 72,)),
                      HomeCard(text: "Novo Registro", index: 3, updateIndex: widget.updateIndex, icon: Image.asset('assets/images/new_register.png', height: 72, width: 72,)),
                      RedirectHomeCard(text: "Fauna Local", icon: Image.asset('assets/images/bird.png', height: 72, width: 72,), websiteUrl: "https://www.ufrgs.br/faunamarinhars/"),
                      HomeCard(text: "Painel de Registros", index: 5, updateIndex: widget.updateIndex, icon: Image.asset('assets/images/register_pannel.png', height: 72, width: 72,)),
                      if (shouldDisplayAdminFeatures)
                        AnimatedOpacity(
                          opacity: _showAdminCards ? 1.0 : 0.0,
                          duration: animationDuration,
                          curve: animationCurve,
                          child: HomeCard(text: "Avaliar Registro", index: 6, updateIndex: widget.updateIndex, icon: Image.asset('assets/images/search.png', height: 72, width: 72,)),
                        ),
                      if (shouldDisplayAdminFeatures)
                        AnimatedOpacity(
                          opacity: _showAdminCards ? 1.0 : 0.0,
                          duration: animationDuration,
                          curve: animationCurve,
                          child: HomeCard(text: "Adicionar Pesquisador", index: 7, updateIndex: widget.updateIndex, icon: Image.asset('assets/images/add_researcher.png', height: 72, width: 72,)),
                        ),
                      if (isAdmin && !_hasInternet)
                         GridTile(
                           child: Card(
                            color: Colors.grey.shade300,
                             child: const Center(
                               child: Padding(
                                 padding: EdgeInsets.all(8.0),
                                 child: Text(
                                   "Funcionalidades de administrador apenas estão disponíveis com internet",
                                   textAlign: TextAlign.center,
                                   style: TextStyle(fontSize: 12, color: Colors.black54),
                                 ),
                               ),
                             ),
                           ),
                         ),
                      if (isAdmin && !_hasInternet)
                         const SizedBox.shrink(),
                    ],
                  );
                } else {
                  return GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(16.0),
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    children: [
                      HomeCard(text: "Meus Registros", index: 1, updateIndex: widget.updateIndex, icon: Image.asset('assets/images/my_registers.png', height: 72, width: 72,)),
                      HomeCard(text: "Meu Perfil", index: 2, updateIndex: widget.updateIndex, icon: Image.asset('assets/images/profile.png', height: 72, width: 72,)),
                      HomeCard(text: "Novo Registro", index: 3, updateIndex: widget.updateIndex, icon: Image.asset('assets/images/new_register.png', height: 72, width: 72,)),
                      HomeCard(text: "Fauna Local", index: 4, updateIndex: widget.updateIndex, icon: Image.asset('assets/images/bird.png', height: 72, width: 72,)),
                      HomeCard(text: "Painel de Registros", index: 5, updateIndex: widget.updateIndex, icon: Image.asset('assets/images/register_pannel.png', height: 72, width: 72,)),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}