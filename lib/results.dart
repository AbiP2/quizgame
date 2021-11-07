import 'package:flutter/material.dart';
import 'package:quizgame/home.dart';

// ignore: camel_case_types
class results extends StatefulWidget {
  int marks;
  results({Key key, @required this.marks}) : super(key: key);
  @override
  _resultsState createState() => _resultsState(marks: marks);
}

// ignore: camel_case_types
class _resultsState extends State<results> {
  var marks;
  _resultsState({this.marks});
  List<String> images = [
    'assets/images/good.jpg',
    'assets/images/average.png',
    'assets/images/bad.jpg'
  ];
  String message;
  String image;

  @override
  void initState() {
    if (marks < 5) {
      image = images[2];
      message = 'You should try hard..\n' + ' you scored $marks';
    } else if (marks < 10 && marks > 5) {
      image = images[1];
      message = 'You can do better\n' + ' you scored $marks';
    } else {
      image = images[0];
      message = 'You did very well..\n' + ' you scored $marks';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Material(
                        child: Container(
                            height: 300.0,
                            width: 300.0,
                            child: ClipRect(
                              child: Image(
                                image: AssetImage(image),
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Material(
                        child: Container(
                          child: Text(
                            message,
                            style: TextStyle(
                                fontSize: 30.0, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.indigoAccent),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0))),
              ),
            ),
            Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Material(
                      child: Container(
                        child: OutlineButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 25.0),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => home()));
                          },
                          splashColor: Colors.cyan,
                          color: Colors.red,
                          child: Text(
                            'Continue',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          borderSide: BorderSide(
                              width: 3.0, color: Colors.indigoAccent),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
