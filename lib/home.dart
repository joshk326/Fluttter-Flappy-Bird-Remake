// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ddtn/constats.dart';
import 'package:ddtn/widgets.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopGameTile(
            screenFlex: 3,
            color: Colors.blue,
            child: Player(),
          ),
          BottomGameTile(
            screenFlex: 1,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                Colors.purple,
              ],
            )),
            child: ScoreBoard(
              score: score,
            ),
          ),
        ],
      ),
    );
  }
}
