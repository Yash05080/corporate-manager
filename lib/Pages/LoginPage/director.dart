import 'package:corporate_manager/Pages/HomePage/HomePage.dart';
import 'package:corporate_manager/Pages/LoginPage/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainDirector extends StatefulWidget {
  const MainDirector({super.key});

  @override
  State<MainDirector> createState() => _MainDirectorState();
}

class _MainDirectorState extends State<MainDirector> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyHomePage();
          } else {
            return Loginpage();
          }
        },
      ),
    );
  }
}