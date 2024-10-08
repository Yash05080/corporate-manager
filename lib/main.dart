
import 'package:corporate_manager/autherisation/LoginPage/MainDirector.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Corporate Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:HexColor("fff8f5")),
        useMaterial3: true,
      ),
      home: const MainDirector(),
    );
  }
}
