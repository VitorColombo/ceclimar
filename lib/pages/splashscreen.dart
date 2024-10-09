import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tcc_ceclimar/pages/base_page.dart';
import 'package:tcc_ceclimar/pages/login.dart';
import 'package:tcc_ceclimar/widgets/circular_image_widget.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacementNamed(BasePage.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularImageWidget(
                imageProvider: AssetImage('assets/images/logo.png'),
                width: 249,
                heigth: 286,
              ),
              Padding(
                padding: EdgeInsets.only(left: 100, right: 100),
                child: LinearProgressIndicator(
                  color: Color.fromARGB(255, 36, 53, 101),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}