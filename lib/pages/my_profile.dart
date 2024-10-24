import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/controller/auth_user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc_ceclimar/widgets/header_banner_widget.dart';
import '../models/user_data.dart';
import '../widgets/modal_help_register_image_btnsheet.dart';
import '../widgets/page_header.dart';
import '../widgets/profile_switch.dart';

class MyProfile extends StatefulWidget {
  static const String routeName = '/myprofile'; 
  final Function(int) updateIndex;

  MyProfile({super.key, this.updateIndex = _defaultUpdateIndex,});
  
  static void _defaultUpdateIndex(int index) {}

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final AuthenticationController _controller = AuthenticationController();
  bool isUltimosRegistros = true;

  void _logout(BuildContext context) {
    _controller.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    UserResponse? userData = _controller.getUserInfo();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 266,
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
            pinned: true,
            floating: false,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text(
                  '${userData?.name}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 9),
                Text(
                  "Registros realizados: 123",//todo integração
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 20),
                ProfileSwitch(size: 600),
                SizedBox(height: 20),
              ]
            )
          )
        ]
      )
    );
  }

  void _showImageObservationBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const ModalHelpRegisterImageBottomSheet();
      },
    );
  }
}

class UltimosRegistrosContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('Pinguim de Magalhães'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Xangri-lá'),
              Text('Enviado em 20/10/2020'),
            ],
          ),
        ),
        ListTile(
          title: Text('Lobo Marinho'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Imbé'),
              Text('Enviado em 20/10/2020'),
            ],
          ),
        ),
      ],
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