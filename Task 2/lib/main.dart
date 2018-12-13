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
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController controller = new TextEditingController();
  final TextEditingController controllerPass = new TextEditingController();

  String _email = "";
  String _password = "";

  Widget detailScreen(){
  
    Widget logo = Container(child: Image.asset('assets/LogoCompBgLess.png',width: 200.0,height: 200.0),margin: const EdgeInsets.all(10.0));
    
    String _emailvalidation(String val){
      return !val.contains('@') ? "Invalid email":null;
    }

    String _passwordvalidation(String val){
      return !(val.length > 8)? "Invalid password":null;  
    }


    void _submitted(){
      if(formKey.currentState.validate()){
      final form = formKey.currentState;
      form.save();
      print("Email: $_email\nPassword:$_password");
      final _snackbar = new SnackBar(content: new Text("Email: $_email\nPassword: $_password"));
      scaffoldKey.currentState.showSnackBar(_snackbar);
      }
    }

    Widget username = Container(child: TextFormField(
      decoration: InputDecoration(labelText: "Enter Username",
      hintText: "Username",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0)
      )
      ),
      validator: _emailvalidation,
      onSaved: (String val)=> _email = val),
      margin: const EdgeInsets.all(20.0));
    
    Widget password = Container(child: TextFormField(
      decoration: InputDecoration(labelText: "Enter Password",
      hintText: "Password",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0)
      )
      ),
      validator: _passwordvalidation,
      obscureText: true,
      onSaved: (String val) => _password = val),
      margin: const EdgeInsets.all(20.0));

    Widget submitButton = Container(child: RaisedButton(child: new Text("SUBMIT"), padding: EdgeInsets.all(8.0),
      onPressed: _submitted, 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
      ),
      margin: const EdgeInsets.all(20.0));
    

    return Form(key:formKey,child:Column(
      children: [logo,username,password,submitButton],
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
    ));
  }

  @override
  Widget build(BuildContext context){
    // title: Text("Login Page")
    return Scaffold(
    key: scaffoldKey,
    body: detailScreen()
    );
  }

}