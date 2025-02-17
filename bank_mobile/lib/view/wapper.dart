import 'package:bank_mobile/view/homepage.dart';
import 'package:bank_mobile/view/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wapper extends StatefulWidget {
  const Wapper({super.key});

  @override
  State<Wapper> createState() => _WapperState();
}

class _WapperState extends State<Wapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Homepage();
            } else {
              return const LoginPage();
            }
          }),
    );
  }
}
