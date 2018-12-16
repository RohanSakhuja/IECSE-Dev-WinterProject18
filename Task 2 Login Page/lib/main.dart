import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return new MaterialApp(
        title: "Winter Project",
        home: Scaffold(
          body: LoginPage(),
          ) ,
        debugShowCheckedModeBanner: false,
      );
    }
}

class LoginPage extends StatefulWidget {
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  final logo = new Hero(
    tag: "logo",
    child: Image.asset('logo.png'),
  );

  final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

  @override
  Widget build(BuildContext context) {
      return ListView(
            padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
            children: <Widget>[
              SizedBox(height: 30.0,),
              logo,
              SizedBox(height: 60.0,),
              email,
              SizedBox(height: 20.0,),
              password,
              SizedBox(height: 20.0,),
              RaisedButton(
                onPressed: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => MyAnimation()));
                },
                color: Colors.lightBlueAccent,
                elevation: 5.0,
                padding: EdgeInsets.all(8.0),
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                child: new Text('Log In', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
    }
}

// Bonus Task Solution
class MyAnimation extends StatefulWidget {
  @override
  MyAnimationState createState() => MyAnimationState();
}

class MyAnimationState extends State<MyAnimation>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children:<Widget>[
          new Center(
            child: new Hero(
              tag: "logo",
              child: Image.asset('logo.png', width: 150, height: 150,),
            ),
          ),
          Positioned(
            top: 0.65*(MediaQuery.of(context).size.height),
            left: 0.36*(MediaQuery.of(context).size.width),
            child: SizedBox(
              child: LinearProgressIndicator(),
              width: 110.0,
              height: 10.0,
            ),
          ),
        ],
      ),
    );
    }
}