import 'dart:async';
import 'package:flutter/material.dart';

import '../login/login_page/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        //Color(0xffB312C3),
        padding: EdgeInsets.all(60),
        child: Center(
          child: Image.asset("imagens/logounithy.png"),
        ),
      ),
    );
  }
}
