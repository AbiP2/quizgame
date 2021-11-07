import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizgame/home.dart';

// ignore: camel_case_types
class splashscreen extends StatefulWidget {
  @override
  _splashscreenState createState() => _splashscreenState();
}

// ignore: camel_case_types
class _splashscreenState extends State<splashscreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lime,
        body: Center(
            child: Material(
          borderRadius: BorderRadius.circular(95.0),
          child: Container(
            child: ClipOval(
              child: Image.asset('assets/images/quiz.png',
                  height: 180.0, fit: BoxFit.cover),
            ),
          ),
        )));
  }
}
