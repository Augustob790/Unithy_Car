import 'package:flutter/material.dart';

import 'app/RouteGenerator.dart';
import 'app/views/splash_page/splash_page.dart';

final ThemeData temaPadrao = ThemeData(primaryColor: Colors.amberAccent

    //Color(0xffB312C3), accentColor: Color(0xffB312C3)
    );

void main() => runApp(MaterialApp(
      title: "UNITHY",
      home: SplashScreen(),
      theme: new ThemeData(
          primaryColor: Colors.amber, //Color(0xffB312C3),
          secondaryHeaderColor: Colors.amberAccent /*Color(0xffB312C3)*/),
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    ));
