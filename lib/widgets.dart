// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:math' as math;
import 'package:ddtn/constats.dart';
import 'package:ddtn/functions.dart';
import 'package:flutter/material.dart';

class BottomGameTile extends StatelessWidget {
  final int screenFlex;
  final Decoration decoration;
  final Widget? child;
  const BottomGameTile(
      {Key? key,
      required this.screenFlex,
      required this.decoration,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: screenFlex,
        child: Container(
          decoration: decoration,
          child: child,
        ));
  }
}

class TopGameTile extends StatefulWidget {
  final int screenFlex;
  final MaterialColor color;
  final Widget? child;
  const TopGameTile(
      {Key? key, required this.screenFlex, required this.color, this.child})
      : super(key: key);

  @override
  _TopGameTile createState() => _TopGameTile();
}

class _TopGameTile extends State<TopGameTile> {
  double playerX = 0.0;
  static double playerY = 0.0;
  double time = 0.4;
  double height = 0.0;
  double playerVelocity = 2.5;
  bool gameStarted = false;
  bool gameReset = false;
  double initialHeight = playerY;
  static double buildingXOne = 2;
  double buildingXTwo = buildingXOne + 1.3;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = playerY;
    });
  }

  void startGame() {
    gameStarted = true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = (-4.9 * (time * time)) + (playerVelocity * time);
      setState(() {
        playerY = initialHeight - height;
        buildingXOne -= 0.05;
        buildingXTwo -= 0.05;
        if (buildingXOne < -2) {
          buildingXOne += 3;
        } else {
          buildingXOne -= 0.05;
        }
        if (buildingXTwo < -2) {
          buildingXTwo += 3;
        } else {
          buildingXTwo -= 0.05;
        }
      });
      // if (buildingXOne < playerX || buildingXTwo < playerX) {
      //   updateScore();
      // }
      if (isPlayerColliding(buildingXOne) ||
          isPlayerColliding(buildingXTwo) ||
          playerY > 1) {
        timer.cancel();
        resetGame();
      }
    });
  }

  bool isPlayerColliding(double buildingX) {
    if (playerX > buildingX - 0.3 && playerX < buildingX + 0.3) {
      return true;
    }
    return false;
  }

  void updateScore() {
    setState(() {
      score += 1;
    });
  }

  void resetGame() {
    setState(() {
      buildingXOne = 2;
      playerY = 0;
      buildingXTwo = buildingXOne + 1.3;
      gameReset = true;
      gameStarted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: widget.screenFlex,
        child: GestureDetector(
          onTap: () {
            if (gameStarted) {
              jump();
            } else {
              startGame();
            }
          },
          child: !gameReset
              ? Game(
                  playerX: playerX,
                  playerY: playerY,
                  widget: widget,
                  buildingXOne: buildingXOne,
                  buildingXTwo: buildingXTwo,
                  gameStarted: gameStarted)
              : GestureDetector(child: Explosion()),
        ));
  }
}

class Game extends StatelessWidget {
  const Game({
    Key? key,
    required this.playerX,
    required this.playerY,
    required this.widget,
    required this.buildingXOne,
    required this.buildingXTwo,
    required this.gameStarted,
  }) : super(key: key);

  final double playerX;
  final double playerY;
  final TopGameTile widget;
  final double buildingXOne;
  final double buildingXTwo;
  final bool gameStarted;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
            alignment: Alignment(playerX, playerY),
            duration: Duration(milliseconds: 0),
            //color: widget.color,
            child: widget.child,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/background.jpg')))),
        AnimatedContainer(
            alignment: Alignment(buildingXOne, 1),
            duration: Duration(milliseconds: 0),
            child: Building(size: 200.0)),
        AnimatedContainer(
            alignment: Alignment(buildingXTwo, -1),
            duration: Duration(milliseconds: 0),
            child: Building(size: 240.0)),
        AnimatedContainer(
            alignment: Alignment(buildingXOne, -1),
            duration: Duration(milliseconds: 0),
            child: Building(size: 200.0)),
        AnimatedContainer(
            alignment: Alignment(buildingXTwo, 1),
            duration: Duration(milliseconds: 0),
            child: Building(size: 210.0)),
        Container(
          alignment: Alignment(0, -0.5),
          child: Text(
            gameStarted ? '' : 'TAP TO PLAY',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ],
    );
  }
}

class Player extends StatelessWidget {
  const Player({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80, width: 80, child: Image.asset('assets/images/bomb.png'));
  }
}

class ScoreBoard extends StatefulWidget {
  final int score;
  const ScoreBoard({Key? key, required this.score}) : super(key: key);

  @override
  _ScoreBoard createState() => _ScoreBoard();
}

class _ScoreBoard extends State<ScoreBoard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SCORE',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              widget.score.toString(),
              style: TextStyle(color: Colors.white, fontSize: 35),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'HIGHSCORE',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              '0',
              style: TextStyle(color: Colors.white, fontSize: 35),
            ),
          ],
        )
      ],
    );
  }
}

class Building extends StatelessWidget {
  final double size;
  const Building({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      height: size,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/building.png'))),
    );
  }
}

class Explosion extends StatelessWidget {
  const Explosion({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        width: 200,
        child: Image.asset('assets/images/explosion.png'));
  }
}
