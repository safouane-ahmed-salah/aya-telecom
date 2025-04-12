import 'package:flutter/material.dart';
import 'package:ayatelecom/Login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تسجيل الدخول',
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: LoginPage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}