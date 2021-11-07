import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quizgame/quiz.dart';
import 'package:quizgame/quiz1.dart';
import 'package:quizgame/quiz2.dart';

// ignore: camel_case_types
class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

// ignore: camel_case_types
class _homeState extends State<home> {
  List<String> name = ['Python', 'Java', 'Java Script'];
  List<String> image = [
    'assets/images/python.jpg',
    'assets/images/java1.jpg',
    'assets/images/javascript.png'
  ];
  void lang(String name) {
    if (name == 'Python') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => loadjson()));
    } else if (name == 'Java') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => loadjson1()));
    } else if (name == 'Java Script') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => loadjson2()));
    }
  }

  Widget customcard(name, image) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
      child: InkWell(
        onTap: () {
          lang(name);
        },
        child: Material(
          color: Colors.red,
          elevation: 20.0,
          borderRadius: BorderRadius.circular(25.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: ClipOval(
                    child: Image(
                      image: AssetImage(image),
                      height: 130.0,
                      width: 130.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Center(
                    child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  DateTime current;
  Future<bool> popped() {
    DateTime now = DateTime.now();
    if (current == null || now.difference(current) > Duration(seconds: 2)) {
      current = now;
      Fluttertoast.showToast(
          msg: 'press back again to exit', toastLength: Toast.LENGTH_SHORT);
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => popped(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Quiz Game',
            textAlign: TextAlign.center,
          ),
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          children: <Widget>[
            customcard(name[0], image[0]),
            customcard(name[1], image[1]),
            customcard(name[2], image[2]),
          ],
        ),
      ),
    );
  }
}
