import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:tcc_ceclimar/controller/auth_user_controller.dart';
import 'package:tcc_ceclimar/controller/my_registers_controller.dart';
import 'package:tcc_ceclimar/models/user_data.dart';
import 'package:tcc_ceclimar/pages/about_us.dart';
import 'package:tcc_ceclimar/pages/home.dart';
import 'package:tcc_ceclimar/pages/local_animals.dart';
import 'package:tcc_ceclimar/pages/my_profile.dart';
import 'package:tcc_ceclimar/pages/my_registers.dart';
import 'package:tcc_ceclimar/pages/new_researcher_user.dart';
import 'package:tcc_ceclimar/pages/new_simple_register.dart';
import 'package:tcc_ceclimar/pages/new_technical_register.dart';
import 'package:tcc_ceclimar/pages/pending_registers.dart';
import 'package:tcc_ceclimar/pages/register_pannel.dart';
import 'package:tcc_ceclimar/widgets/new_register_floating_btn.dart';

class BasePage extends StatefulWidget {
  static const String routeName = '/basePage';
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int selectedIndex = 0;
  int _currentRegisterCount = 0;
  int _lastSeenRegisterCount = 0;
  final MyRegistersController _controller = MyRegistersController();
  final AuthenticationController _authController = AuthenticationController();
  bool _initialized = false;
  late String _currentUserId;
  late Box<int> _registerCountBox;
  late Stream<int> _registerCountStream;

  void updateIndex(int index) {
    setState(() {
      selectedIndex = index;
      if (index == 1) {
        _updateLastSeenCount();
      }
    });
  }

  void _updateCurrentCount(int count) {
    if (mounted && _currentUserId.isNotEmpty) {
      setState(() {
        _currentRegisterCount = count;
      });
    }
  }

  void _updateLastSeenCount() async {
    if (mounted) {
      await _registerCountBox.put('lastSeen', _currentRegisterCount);
      setState(() {
        _lastSeenRegisterCount = _currentRegisterCount;
      });
    }
  }

  Future<void> _openHiveBox() async {
    UserResponse? user = _authController.getUserInfo();
    if (user == null) {
      return;
    }
    _currentUserId = user.uid;
    final boxName = 'register_count_box_$_currentUserId';
    _registerCountBox = await Hive.openBox<int>(boxName);
    _lastSeenRegisterCount = _registerCountBox.get('lastSeen') ?? 0;
  }

  @override
  void initState() {
    super.initState();
    _openHiveBox();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is int) {
        updateIndex(args);
      }
    });

    _registerCountStream = _controller.getRegistersCountStream();
    _registerCountStream.listen((count) {
      if (!_initialized) {
        if (count > 0) _initialized = true;
      }
      if (count != 0 || !_initialized) {
        _updateCurrentCount(count);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> get pages => [
    HomePage(updateIndex: updateIndex),
    MyRegisters(updateIndex: updateIndex),
    MyProfile(updateIndex: updateIndex),
    NewSimpleRegister(updateIndex: updateIndex),
    LocalAnimals(updateIndex: updateIndex),
    RegisterPannel(updateIndex: updateIndex),
    PendingRegisters(updateIndex: updateIndex),
    NewResearcherPage(updateIndex: updateIndex),
    NewTechnicalRegister(updateIndex: updateIndex),
    AboutUs(updateIndex: updateIndex),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (selectedIndex != 0) {
          updateIndex(0);
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: pages[selectedIndex],
        bottomNavigationBar: bottomNavBar(context),
      ),
    );
  }

  Container bottomNavBar(BuildContext context) {
    return Container(
      height: 82,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  updateIndex(0);
                },
                icon: selectedIndex == 0
                    ? Icon(
                        PhosphorIcons.house(PhosphorIconsStyle.fill),
                        size: 25,
                      )
                    : Icon(
                        PhosphorIcons.house(PhosphorIconsStyle.regular),
                        size: 25,
                      ),
              ),
              GestureDetector(
                onTap: () {
                  updateIndex(0);
                },
                child: label("Início", 0)
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  updateIndex(1);
                },
                icon: StreamBuilder<int>(
                  stream: _registerCountStream,
                  builder: (context, snapshot) {
                    int currentCount = snapshot.data ?? 0;
                    bool hasNewRegister =
                        currentCount > _lastSeenRegisterCount;
                    return selectedIndex == 1
                        ? badges.Badge(
                            showBadge: hasNewRegister,
                            badgeContent: Text(
                                (currentCount - _lastSeenRegisterCount)
                                    .toString(),
                                style: const TextStyle(color: Colors.white)),
                            child: Icon(
                              PhosphorIcons.list(PhosphorIconsStyle.fill),
                              size: 25,
                            ),
                          )
                        : badges.Badge(
                            showBadge: hasNewRegister,
                            badgeStyle: badges.BadgeStyle(
                              badgeColor: Colors.red,
                              padding: EdgeInsets.all(4),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                            ),
                            badgeContent: Text(
                                (currentCount - _lastSeenRegisterCount)
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal
                                )
                            ),
                            badgeAnimation: badges.BadgeAnimation.rotation(
                              animationDuration: const Duration(seconds: 1),
                              colorChangeAnimationDuration:
                                  const Duration(seconds: 1),
                              loopAnimation: false,
                              curve: Curves.fastOutSlowIn,
                            ),
                            child: Icon(
                              PhosphorIcons.list(PhosphorIconsStyle.regular),
                              size: 25,
                            ),
                          );
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  updateIndex(1);
                },
                child: label("Registros", 1),
              ),
            ],
          ),
          AddNewRegisterFloatingBtn(updateIndex: updateIndex),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  updateIndex(2);
                },
                icon: selectedIndex == 2
                    ? Icon(
                        PhosphorIcons.user(PhosphorIconsStyle.fill),
                        size: 25,
                      )
                    : Icon(
                        PhosphorIcons.user(PhosphorIconsStyle.regular),
                        size: 25,
                      ),
              ),
              GestureDetector(
                onTap: () {
                  updateIndex(2);
                },
                child: label("Perfil", 2),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  updateIndex(9);
                },
                icon: selectedIndex == 9
                    ? Icon(
                        PhosphorIcons.info(PhosphorIconsStyle.fill),
                        size: 25,
                      )
                    : Icon(PhosphorIcons.info(PhosphorIconsStyle.regular),
                        size: 25,
                      ),
              ),
              GestureDetector(
                onTap: () {
                  updateIndex(9);
                },
                child: label("Sobre", 9),
              ),
            ],
          ),
        ],
      ),
    );
  }

  label(String s, index) {
    return Transform.translate(
      offset: const Offset(0, -10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: s,
            style: TextStyle(
              fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}