import 'package:flutter/material.dart';
import 'chuck.dart';

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

  final authEmail = "RohanSakhuja@gmail.com";
  final authPassword = "password";

  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  Future delay() async{
    await new Future.delayed(new Duration(milliseconds: 3500), ()
    {
      Navigator.of(context).pop();
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => CategoryPage())
      );

    });
  }

  @override
  Widget build(BuildContext context) {
      final email = TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Email',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      );

      final password = TextFormField(
        controller: passwordController,
        autofocus: false,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      );
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
                  if(emailController.text == authEmail && passwordController.text == authPassword){
                    delay();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyAnimation()));
                  } else {
                    emailController.clear();
                    passwordController.clear();
                    showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: Text("Invalid Credentials!"),
                          content: Text("Email or Password is Incorrect, Try Again!"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("Close"),
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      },
                    );
                  }
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