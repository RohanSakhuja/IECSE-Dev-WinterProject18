import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Chuck Norris App",
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  State createState() => new HomePageState();
}

class HomePageState extends State<HomePage>{
 
  Future<List<String>> getCats() async {
  final response = await http.get('https://api.chucknorris.io/jokes/categories');
  final categories = json.decode(response.body);
  List<String> Cats = [];
  for( var cat in categories){
    Cats.add(cat.toString());
  }
  return Cats;
 }

  
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Chuck Norris Jokes'),
      ),
      body: new Container(
        child: FutureBuilder(
          future: getCats(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data ==  null){
              return Container(
                child: Center(
                  child: Text("Waiting....")
                ),
              );
            }
            else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context ,int index){
                return ListTile(
                  title: new Text(snapshot.data[index]),
                  leading: Icon(Icons.arrow_forward),
                  onTap: (){print(snapshot.data[index]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> new JokeScreen(snapshot.data[index]))
                    );
                  },
                );
              }
            );
           }
          },
        )
      ),
    );
  }


}
class Joke{
  final String value;
  Joke({this.value});
  factory Joke.fromJson(Map<String,dynamic> parsedJson){
    return Joke(value: parsedJson['value']);
  }
}

class JokeScreen extends StatelessWidget {
  var specific='';
  JokeScreen(this.specific);

  Future<String> getJoke(specific) async {    
     final response = await http.get('https://api.chucknorris.io/jokes/random?category=$specific');
     final rsp = json.decode(response.body);
     Joke joke = new Joke.fromJson(rsp);
     print(joke.value);
     return joke.value;
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: new Text("$specific"),),
      body: new Container(
        child: FutureBuilder(
          future: getJoke(specific),
          builder: (BuildContext context , AsyncSnapshot snapshot){
              if(snapshot.data ==  null){
              return Container(
                child: Center(
                  child: Text("Loading Joke....")
                ),
              );
            }
            else{
              return Center(
                child: new Container(
                  child: new Text(snapshot.data) ,
                  padding: EdgeInsets.all(30.0),) ,);
            }
          },                                         //new Text(snapshot.data)
        ),
      ),
    );
  }
}
