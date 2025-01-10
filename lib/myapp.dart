import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/controller/new_register_form_controller.dart';
import 'package:tcc_ceclimar/models/register_response.dart';
import 'package:tcc_ceclimar/pages/about_us.dart';
import 'package:tcc_ceclimar/pages/base_page.dart';
import 'package:tcc_ceclimar/pages/edit_profile.dart';
import 'package:tcc_ceclimar/pages/evaluate_register.dart';
import 'package:tcc_ceclimar/pages/pending_registers.dart';
import 'package:tcc_ceclimar/pages/forgot_pass.dart';
import 'package:tcc_ceclimar/pages/home.dart';
import 'package:tcc_ceclimar/pages/local_animals.dart';
import 'package:tcc_ceclimar/pages/my_profile.dart';
import 'package:tcc_ceclimar/pages/my_registers.dart';
import 'package:tcc_ceclimar/pages/new_simple_register.dart';
import 'package:tcc_ceclimar/pages/new_technical_register.dart';
import 'package:tcc_ceclimar/pages/register_pannel.dart';
import 'package:tcc_ceclimar/pages/register_view.dart';
import 'package:tcc_ceclimar/pages/splashscreen.dart';
import 'package:tcc_ceclimar/pages/sign_user.dart';
import 'package:tcc_ceclimar/pages/login.dart';
import 'package:tcc_ceclimar/pages/new_researcher_user.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NewRegisterFormController controller = NewRegisterFormController();
  @override
  void initState() {
    super.initState();
    controller.initConnectivityListener(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fauna Marinha RS',
      locale: Locale('pt', 'BR'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('pt', 'BR'),
      ],
      theme: ThemeData(
        useMaterial3: true,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black),
          titleMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(fontSize: 15.0),
          bodySmall: TextStyle(fontSize: 11.0, color:  Color.fromARGB(255, 31, 73, 95)),
          labelLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.grey),
          labelMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.black),
        ),
        fontFamily: "Inter",
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary:const Color.fromARGB(255, 31, 73, 95),
          secondary:  const Color.fromARGB(255, 71, 169, 218),
          surface: Colors.white,
          outline: const Color.fromARGB(150, 100, 99, 99),
          surfaceContainerHighest: const Color.fromARGB(149, 194, 194, 194),
        ),
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(email: "",),
        NewUserPage.routeName: (context) => const NewUserPage(email: "",),
        LoginPage.routeName: (context) => const LoginPage(email: "",),
        NewResearcherPage.routeName: (context) => const NewResearcherPage(),
        HomePage.routeName: (context) => HomePage(updateIndex: (int index) {}),
        EvaluateRegister.routeName: (context) => EvaluateRegister(
                register: ModalRoute.of(context)!.settings.arguments as RegisterResponse,
              ),
        PendingRegisters.routeName: (context) => const PendingRegisters(),
        LocalAnimals.routeName: (context) => const LocalAnimals(),
        MyProfile.routeName: (context) => MyProfile(),
        MyRegisters.routeName: (context) => const MyRegisters(),
        NewSimpleRegister.routeName: (context) => const NewSimpleRegister(),
        RegisterPannel.routeName: (context) => const RegisterPannel(),
        BasePage.routeName: (context) => const BasePage(),
        NewTechnicalRegister.routeName: (context) => const NewTechnicalRegister(),
        AboutUs.routeName:(context) => const AboutUs(),
        RegisterDetailPage.routeName:(context) => RegisterDetailPage(
                register: ModalRoute.of(context)!.settings.arguments as RegisterResponse,
              ),
        EditProfile.routeName:(context) => const EditProfile(),
      },
    );
  }
}