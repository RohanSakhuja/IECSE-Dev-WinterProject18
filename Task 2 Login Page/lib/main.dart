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


      body: Container(

        margin: EdgeInsets.all(_minimumPadding * 5),
        child: ListView(
          children: <Widget>[

            getImageAsset(),

            Padding(
                padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child: Center(
                    child: Container(
                        alignment: Alignment.center,
                        width: 320.0,
                        height: 35.0,
                        child: TextFormField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                      labelText: '  EMAIL',
                      hintText: '  Enter EMAIL ID',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)
                      )
                  ),
                )))),

            Padding(
                padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child: Center(
                    child: Container(
                        alignment: Alignment.center,
                        width: 320.0,
                        height: 50.0,
                        child: TextFormField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                      labelText: '  PASSWORD',
                      hintText: '  Enter Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)
                      )
                  ),
                )))),


            Padding(
                padding: EdgeInsets.only(bottom: _minimumPadding, top: _minimumPadding),
                child: Row(children: <Widget>[
                  Expanded(

              child: Container(
              alignment: Alignment.center,
               width: 790.0,
               height: 60.0,
                    child: ButtonTheme(
                      minWidth: 320.0,
                      height: 40.0,
                      child: RaisedButton(
                      color: Colors.blue,
                      // ignore: expected_token
                      child:  Text('log in'),
                        textColor: Colors.white,
                      elevation: 10.0,
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () { print('Button Pressed');

                      },
                    ),
                  ),


             ))],)),

          ],
        ),
      ),
    );
  }

  Widget getImageAsset() {

    AssetImage assetImage = AssetImage('assets/logo.png');
    Image image = Image(image: assetImage, width: 145.0, height: 245.0,);

    return Container(child: image, margin: EdgeInsets.all(_minimumPadding * 10),);
  }
}