import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dont Drop the Nuke',
      theme: ThemeData(
        backgroundColor: Colors.white,
      ),
      home: const Home(),
    );
  }
}
