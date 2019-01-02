import 'package:flutter/material.dart';
import 'home.dart';

class LoginPage extends StatefulWidget 
{
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> 
{
  @override
  Widget build(BuildContext context) 
  {
    final logo = Hero
    (
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 140.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final email = TextFormField
    (
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: '',
      decoration: InputDecoration(
        hintText: 'Naam Batao',
        contentPadding: EdgeInsets.fromLTRB(20.0, 7.0, 20.0, 7.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(35.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: '',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password Batao',
        contentPadding: EdgeInsets.fromLTRB(20.0, 7.0, 20.0, 7.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(35.0),),
      
      ),
    );

    final loginButton = Padding
    (
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
        //shape: CircleBorder(),
        type: MaterialType.transparency,
        shadowColor: Colors.redAccent,
        elevation:10.0,
        child: RaisedButton
        (
          shape:StadiumBorder(),
          padding: EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
          onPressed: () 
          {
            Navigator.of(context).pushNamed(HomePage.tag);
          },
          color: Colors.blueGrey,
          child: Text('Unko Bata De?', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    return Scaffold
    (
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 40.0),
            email,
            SizedBox(height: 10.0),
            password,
            SizedBox(height: 10.0),
            loginButton,
          ],
        ),
      ),
    );
  }
}
