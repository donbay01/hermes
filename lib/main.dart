import 'package:flutter/material.dart';
import 'package:hermeslogistics/slider/login.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hermes Logistics',
      theme: ThemeData(
        primarySwatch: Colors.orange
      ),
      home: Splash(),
    );
  }
}
