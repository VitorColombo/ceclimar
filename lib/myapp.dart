import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/pages/base_page.dart';
import 'package:tcc_ceclimar/pages/evaluate_register.dart';
import 'package:tcc_ceclimar/pages/forgot_pass.dart';
import 'package:tcc_ceclimar/pages/home.dart';
import 'package:tcc_ceclimar/pages/local_animals.dart';
import 'package:tcc_ceclimar/pages/my_profile.dart';
import 'package:tcc_ceclimar/pages/my_registers.dart';
import 'package:tcc_ceclimar/pages/new_register.dart';
import 'package:tcc_ceclimar/pages/register_pannel.dart';
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
        NewUserPage.routeName: (context) => const NewUserPage(email: "",),
        LoginPage.routeName: (context) => const LoginPage(email: "",),

        NewResearcherPage.routeName: (context) => const NewResearcherPage(),
        HomePage.routeName: (context) => HomePage(updateIndex: (int index) {}),
        EvaluateRegister.routeName: (context) => const EvaluateRegister(),
        LocalAnimals.routeName: (context) => const LocalAnimals(),
        MyProfile.routeName: (context) => MyProfile(),
        MyRegisters.routeName: (context) => const MyRegisters(),
        NewRegister.routeName: (context) => const NewRegister(),
        RegisterPannel.routeName: (context) => const RegisterPannel(),
        BasePage.routeName: (context) => const BasePage(),
      },
    );
  }
}