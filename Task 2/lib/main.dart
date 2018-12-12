import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: LoginPage(),
    );
  }
}


class LoginPage extends StatelessWidget {

  final formKey = new GlobalKey<FormState>();

  String _email = "";
  String _password = "";

  Widget detailScreen(){
  
    Widget logo = Container(child: Image.asset('assets/LogoCompBgLess.png',width: 200.0,height: 200.0),margin: const EdgeInsets.all(10.0));
    
    void _submitted(){
      final form = formKey.currentState;
      form.save();
      print("Email: $_email\nPassword:$_password");
    }

    Widget username = Container(child: TextFormField(
      decoration: InputDecoration(labelText: "Enter Username",
      hintText: "Username",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0)
      )
      ),
      onSaved: (String val)=> _email = val,),
      margin: const EdgeInsets.all(20.0));
    
    Widget password = Container(child: TextFormField(
      decoration: InputDecoration(labelText: "Enter Password",
      hintText: "Password",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0)
      )
      ),
      obscureText: true,
      onSaved: (String val) => _password = val),
      margin: const EdgeInsets.all(20.0));
    

    Widget submitButton = Container(child: RaisedButton(child: new Text("SUBMIT"), padding: EdgeInsets.all(8.0),
    onPressed: _submitted,),
    margin: const EdgeInsets.all(20.0),
    );
    

    return Column(
      children: [logo,username,password,submitButton],
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }

  @override
  Widget build(BuildContext context){
    // title: Text("Login Page")
    return Scaffold(
    body: detailScreen()
    );
  }

}