import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(18.0),
                child: Container(
                    height: 250,
                    width: 250,
                    child: Image.asset(
                      'image/logo.png',
                    ))),
            Container(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100.0))),
                    color: Colors.white,
                    child: TextFormField(
                        decoration:
                            InputDecoration.collapsed(hintText: 'Email Id')))),
            Container(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100.0))),
                    color: Colors.white,
                    child: TextFormField(
                        obscureText: true,
                        decoration:
                            InputDecoration.collapsed(hintText: 'Password')))),
            Container(
                padding: EdgeInsets.all(10.0),
                constraints: BoxConstraints(maxHeight: 100.0, minWidth: 400.0),
                child: RaisedButton(
                  onPressed: () {
                    print('Verifying...');
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.0))),
                  color: Colors.blue,
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}
