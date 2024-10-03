import 'dart:async';
import 'package:flutter/material.dart';
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
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/images/background1.png',
            fit: BoxFit.cover,
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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