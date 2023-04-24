import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'speedo_meter_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VelocityVision',
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/speedometer':(context) => SpeedometerPage(),
      },
    );
  }
}
