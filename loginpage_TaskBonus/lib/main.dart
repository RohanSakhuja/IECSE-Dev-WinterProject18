import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget 
{
  final routes = <String, WidgetBuilder>
  {
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
  };

  @override
  Widget build(BuildContext context) 
  {
  return MaterialApp
  (
    title: 'Task_2',
    debugShowCheckedModeBanner: false,
    theme: ThemeData
    (
       primarySwatch: Colors.lightBlue,
       fontFamily: 'Nunito',
    ),
    home: LoginPage(),
    routes: routes,
  );
  }
}
