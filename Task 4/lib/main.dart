import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


String catVal;

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
      return null;
    }

    String _passwordvalidation(String val){
      return null;
    }

    void _showDialog(){
      showDialog(
      context: context,
      child: 
        // return object of type Dialog
         AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Invalid Credentials"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
         )
    );
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
        Map emailpass = {"Sanchit":"pass"};
        if(formKey.currentState.validate()){
          final form = formKey.currentState;
          form.save();
          if(emailpass[_email] == _password){
            final welcomeScreen = MaterialPageRoute(builder: (context) => LoadScreen());
            Navigator.push(context, welcomeScreen);
          }else{
            showDialog(
              context: context,
              child: AlertDialog(
                title: Text("Denied"),
                content: Text("Invalid Credentials"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Close"),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  )
                ],
              )
            );
          }
        }
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

class LoadScreen extends StatefulWidget{
  @override
  createState() => new LoadingScreen();

}

class LoadingScreen extends State<LoadScreen> {

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 5),(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>CatPageState()));
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

class Joke{
  final String value;

  Joke({this.value});

  factory Joke.fromJson(Map<String,dynamic> json){
    return Joke(
      value: json['value']
    );
  }
}

Future<Joke> fetchJoke() async {
  final response = 
      await http.get('https://api.chucknorris.io/jokes/random?category=$catVal');
  
  return Joke.fromJson(json.decode(response.body));
}

class Cats{
  final List<String> catList;

  Cats({this.catList});

  factory Cats.fromJson(List<dynamic> json){
    return Cats(catList: json.cast<String>().toList());
  }
}

Future<Cats> fetchCats() async {
  final response = await http.get('https://api.chucknorris.io/jokes/categories');

  return Cats.fromJson(json.decode(response.body));
}

class CatPageState extends StatefulWidget{
  @override
  createState() => new CatsPage();
}

class CatsPage extends State<CatPageState>{

  Future<Cats> postCats = fetchCats();

  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child:Scaffold(
      appBar: AppBar(title: Text("Select Category")),
      body: Container(
        child: FutureBuilder<Cats>(
          future: postCats,
          builder: (context, snapshot){
            if(snapshot.hasData){
              List<String> catList = snapshot.data.catList;
              return Container(
                child: ListView.builder(
                  itemCount: catList.length,
                  itemBuilder: (context, index){
                    String temp = "";
                    if(catList[index] != 'any'){
                      temp = catList[index];
                    }
                    return ListTile(
                      title: Text("$temp"),
                      contentPadding: const EdgeInsets.all(10.0),
                      onTap: (){
                        catVal = temp;
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>RandomJokes(postJoke:fetchJoke()))
                        );
                      },
                    );
                  },
                )
              );
            }else if(snapshot.hasError){
              return Text("Whoopsie Daisy!");
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      )
      )
    );

  }

}

class RandomJokes extends StatelessWidget{

  Future<Joke> postJoke;
  
  RandomJokes({Key key, this.postJoke}) : super(key: key);

   Widget build(BuildContext context){

  final _biggerFont = TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold);
  final _catFont = TextStyle(fontSize: 15.0);

    return Scaffold(appBar: AppBar(title: Text("Category: ${catVal}"),),
    body:Container(child: FutureBuilder<Joke>(
      future: postJoke,
      builder: (context, snapshot){
         if (snapshot.hasData) {
                return Container(child:Center(child:Column(children:[
                                        Text("${snapshot.data.value}",style: _biggerFont),
                                        Text("Category:$catVal",style: _catFont,textAlign: TextAlign.left)
                          ],
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center, 
                          ),
                          ),
                          margin: EdgeInsets.all(32.0)
                          );
              } else if (snapshot.hasError) {
                return Text("whoooops!");
              }
              return Center(child:CircularProgressIndicator());
      }
    )
    )
    );
  }

}