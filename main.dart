import 'package:flutter/material.dart';

void main() {

  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IECSE LOGIN',
        home: Login(),
      )
  );
}

class Login extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return _LoginState();
  }
}

// ignore: expected_type_name
class _LoginState extends State<Login> {

  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  final double  _minimumPadding = 5.0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
//			resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('IECSE LOGIN'),
      ),

      body: Container(

        margin: EdgeInsets.all(_minimumPadding * 2),
        child: ListView(
          children: <Widget>[

            getImageAsset(),

            Padding(
                padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'EMAIL',
                      hintText: 'Enter EMAIL ID',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)
                      )
                  ),
                )),

            Padding(
                padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'PASSWORD',
                      hintText: 'Enter Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)
                      )
                  ),
                )),


            Padding(
                padding: EdgeInsets.only(bottom: _minimumPadding, top: _minimumPadding),
                child: Row(children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Colors.blue,
                      // ignore: expected_token
                      child: new Text('log in'),
                      elevation: 10.0,
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () { print('Button Pressed');

                      },
                    ),
                  ),

                ],)),

          ],
        ),
      ),
    );
  }

  Widget getImageAsset() {

    AssetImage assetImage = AssetImage('images/myimage.jpeg');
    Image image = Image(image: assetImage, width: 145.0, height: 195.0,);

    return Container(child: image, margin: EdgeInsets.all(_minimumPadding * 10),);
  }
}