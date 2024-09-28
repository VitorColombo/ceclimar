import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/pages/splashscreen.dart';
import 'package:tcc_ceclimar/pages/sign_user.dart';
import 'package:tcc_ceclimar/pages/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        CadastroUsuarioPage.routeName: (context) => const CadastroUsuarioPage(),
        LoginPage.routeName: (context) => const LoginPage(),
      },
    );
  }
}