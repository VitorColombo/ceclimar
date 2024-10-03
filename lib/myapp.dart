import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/pages/forgot_pass.dart';
import 'package:tcc_ceclimar/pages/splashscreen.dart';
import 'package:tcc_ceclimar/pages/sign_user.dart';
import 'package:tcc_ceclimar/pages/login.dart';
import 'package:tcc_ceclimar/pages/new_researcher_user.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TCC Ceclimar',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 18.0),
          bodySmall: TextStyle(fontSize: 14.0),

        ),
        fontFamily: "Inter"
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(email: "",),
        CadastroUsuarioPage.routeName: (context) => const CadastroUsuarioPage(email: "",),
        LoginPage.routeName: (context) => const LoginPage(email: "",),
        CadastroPesquisadorPage.routeName: (context) => const CadastroPesquisadorPage()
      },
    );
  }
}