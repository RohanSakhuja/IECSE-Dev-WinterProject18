import 'dart:async';

import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: LoginPage()
    );
  }
}


class LoginPage extends StatelessWidget {

  //From and Scaffold States
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  //unused Controllers
  final TextEditingController controller = new TextEditingController();
  final TextEditingController controllerPass = new TextEditingController();

  //Initialising Email and Password
  String _email = "";
  String _password = "";

  Widget detailScreen(BuildContext context){
  
    //Widget for Logo
    Widget logo = Container(child: Image.asset('assets/LogoCompBgLess.png',
      width: 200.0,
      height: 200.0),
       margin: const EdgeInsets.all(10.0));
    
    //Validation methods
    String _emailvalidation(String val){
      return !val.contains('@') ? "Invalid email":null;
    }

    String _passwordvalidation(String val){
      return !(val.length > 8)? "Invalid password":null;  
    }

    //Method for Submit Button
    void _submitted(){
      if(formKey.currentState.validate()){
        final form = formKey.currentState;
        form.save();
      
        //print("Email: $_email\nPassword:$_password");
      
        final _snackbar = new SnackBar(content: new Text("Email: $_email\nPassword: $_password"));
        scaffoldKey.currentState.showSnackBar(_snackbar);
        
        final welcomeScreen = MaterialPageRoute(builder: (context) => WelcomePage(_email));
        Navigator.push(context, welcomeScreen);
      }
    }

    //Widget for Username
    Widget username = Container(child: TextFormField(
      decoration: InputDecoration(labelText: "Enter Username",
      hintText: "Username",                            
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))),
      validator: _emailvalidation,
      onSaved: (String val)=> _email = val),
      margin: const EdgeInsets.all(20.0));
    
    //Widget for Password
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
      margin: const EdgeInsets.all(20.0)
      );


    //Widget for Submit Button
    Widget submitButton = Container(child: RaisedButton(child: new Text("SUBMIT"), padding: EdgeInsets.all(8.0),
      onPressed: (){
        final welcomeScreen = MaterialPageRoute(builder: (context) => LoadScreen(_email, _password));
        Navigator.push(context, welcomeScreen);
      }, 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
      ),
      margin: const EdgeInsets.all(20.0));
    

    return Form(key:formKey,
      child:Column(
        children: [logo,username,password,submitButton],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center)
    );
  }

  @override
  Widget build(BuildContext context){
    // title: Text("Login Page")
    return Scaffold(
    key: scaffoldKey,
    body: detailScreen(context)
    );
  }

}

class WelcomePage extends StatelessWidget{

  String username;

  WelcomePage(String _username){
    this.username = _username;
  }

  final _biggerFont = const TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold);
  final _smallerFont = const TextStyle(fontSize: 25.0);

  Widget mainPage(){
    
    Widget logo = Container(child: Image.asset('assets/LogoCompBgLess.png',
      width: 200.0,
      height: 200.0),
       margin: const EdgeInsets.all(10.0));
    
    Widget messageID = Container(child:Text("Welcome! ${usernameExtract(username)}",style: _biggerFont,textAlign: TextAlign.center),
                                  margin: const EdgeInsets.all(20.0) );
    
    Widget subMessage = Container(child:Text("To whatever this is supposed to be ",style: _smallerFont,textAlign: TextAlign.center),
                                  margin: const EdgeInsets.all(20.0) );


    return Column(children: [logo, messageID, subMessage],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  );
  }

  String usernameExtract(String username){
    return username.split('@')[0];
  }

  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: mainPage()
        )
      );
  }
}

class LoadScreen extends StatefulWidget{
  String _username;
  String _password;

  LoadScreen(String _username,String _password){
    this._username = _username;
    this._password = _password;
  }
  LoadingScreen createState() => new LoadingScreen(_username, _password);

}

class LoadingScreen extends State<LoadScreen> {

  String _password;
  String _username;

  LoadingScreen(String _username, String _password){
    this._username = _username;
    this._password = _password;
  }

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 5),(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomePage(_username)));
    });
  }

  Widget loadPage(){
    Widget logo = Container(child: Image.asset('assets/LogoCompBgLess.png',
      width: 120.0,
      height: 120.0),
       margin: const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0));

    Widget bar = Container(child: LinearProgressIndicator(),
        margin: const EdgeInsets.all(90.0));

    return Container(child: Column(children: [logo, bar],mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center),
    margin: const EdgeInsets.fromLTRB(60.0, 0.0, 60.0, 0.0)
    );
  }

  @override
  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: ()=>Future.value(false),
      child: Scaffold(
        body: loadPage()
      )
    );
  }

} 

