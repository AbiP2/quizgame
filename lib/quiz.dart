import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quizgame/home.dart';
import 'package:quizgame/results.dart';

// ignore: camel_case_types
class loadjson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          DefaultAssetBundle.of(context).loadString('assets/quiz/python.json'),
      builder: (context, snapshot) {
        var data = json.decode(snapshot.data.toString());
        if (data == null) {
          return Center(child: Text('Loading....'));
        } else {
          return quiz(data: data);
        }
      },
    );
  }
}

// ignore: camel_case_types
class quiz extends StatefulWidget {
  final data;
  quiz({Key key, @required this.data}) : super(key: key);
  // ignore: empty_constructor_bodies
  @override
  _quizState createState() => _quizState(data: data);
}

// ignore: camel_case_types
class _quizState extends State<quiz> {
  var data;
  _quizState({this.data});
  var i = 1;
  var marks = 0;
  bool canceltimer;
  var timer = 30;
  String showtimer = "30";
  Color choose = Colors.cyan;
  Color right = Colors.green;
  Color wrong = Colors.red;
  Map<String, Color> buttonscolor = {
    "a": Colors.cyan,
    "b": Colors.cyan,
    "c": Colors.cyan,
    "d": Colors.cyan
  };

  void checkanswer(String k) {
    canceltimer = true;
    if (data[2][i.toString()] == data[1][i.toString()][k]) {
      marks += 2;
      choose = right;
    } else {
      choose = wrong;
    }
    setState(() {
      buttonscolor[k] = choose;
      Timer(Duration(seconds: 2), nextquestion);
    });
  }

  void nextquestion() {
    canceltimer = false;
    timer = 30;
    setState(() {
      if (i < 5) {
        i++;
      } else {
        canceltimer = true;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => results(marks: marks)));
      }
      buttonscolor["a"] = Colors.cyan;
      buttonscolor["b"] = Colors.cyan;
      buttonscolor["c"] = Colors.cyan;
      buttonscolor["d"] = Colors.cyan;
      starttimer();
    });
  }

  @override
  void initState() {
    starttimer();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void starttimer() async {
    const onsec = Duration(seconds: 1);
    Timer.periodic(onsec, (Timer t) {
      setState(() {
        if (timer < 1) {
          nextquestion();
        } else if (canceltimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showtimer = timer.toString();
      });
    });
  }

  Widget choices(String k) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: MaterialButton(
        onPressed: () => checkanswer(k),
        color: buttonscolor[k],
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        minWidth: 200.0,
        child: Text(
          data[1][i.toString()][k],
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Warning'),
                  content: Text('Are you sure to quit'),
                  actions: <Widget>[
                    Row(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('No'),
                        ),
                        FlatButton(
                          onPressed: () {
                            canceltimer = true;
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => home()));
                          },
                          child: Text('Yes'),
                        )
                      ],
                    )
                  ],
                ));
      },
      child: Scaffold(
          backgroundColor: Colors.tealAccent,
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/pythonback.jpg'),
              fit: BoxFit.cover,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      data[0][i.toString()],
                      style: TextStyle(
                        fontSize: 23.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 6,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          choices('a'),
                          choices('b'),
                          choices('c'),
                          choices('d'),
                        ],
                      ),
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      showtimer,
                      style: TextStyle(fontSize: 25.0, color: Colors.red),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
