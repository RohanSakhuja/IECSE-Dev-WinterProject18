import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'LOGIN PAGE' ,
      home: new LoginPage()
      );
  }
}

class LoginPage extends StatefulWidget{
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  String email = '';
  String password = '';


  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text("Login Page")),
     backgroundColor: Colors.white,
     body: new Container(
       padding: const EdgeInsets.all(50),
       child: new Form(
         autovalidate: true,
         child: new Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Image.asset(
               'assets/logo.png',
                height: 180,
                fit: BoxFit.contain,
               ),
             new Padding(
               padding: const EdgeInsets.all(8.0),
             ),
             new TextFormField(
                decoration: InputDecoration(
                 labelText: 'Enter Email ID',
                 hintText: 'Enter a valid email ID',
                 border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0)
                 ),
               ),
             ),
             new Padding(
               padding: const EdgeInsets.all(8.0),
             ),
             new TextFormField(
                 decoration: InputDecoration(
                 labelText: 'Enter Password',
                 hintText: 'Password goes here',
                 border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0)
                 ),
               ),
               obscureText: true,
             ),
             new Padding(
               padding: const EdgeInsets.all(8.0),
             ),
             new RaisedButton(       
               elevation: 4,       
               child: new Text('Login'), 
               onPressed: (){},
               color: Colors.blue,
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),             
             )

           ],),

      ),
     )
    );
  }
}