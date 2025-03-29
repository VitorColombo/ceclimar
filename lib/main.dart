import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tcc_ceclimar/models/local_register.dart';
import 'package:tcc_ceclimar/myapp.dart';
import 'package:tcc_ceclimar/utils/register_status.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark, 
    ));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(LocalRegisterAdapter());
  Hive.registerAdapter(RegisterStatusAdapter());
  await Hive.openBox<LocalRegister>('registers');
  runApp(const MyApp());
}