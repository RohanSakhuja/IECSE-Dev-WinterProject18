import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String number = '1';
String typeVal = 'people';
String catVal = "";

Future<PostJoke> fetchPostJoke() async {
  final response = 
      await http.get('https://api.chucknorris.io/jokes/random?category=$catVal');
    
  return PostJoke.fromJson(json.decode(response.body));
  
}

class PostJoke{
  final String value;
  
  PostJoke({this.value});

  factory PostJoke.fromJson(Map<String, dynamic> json) {
    return PostJoke(
      value: json['value']
    );
  }

}

void main() => runApp(Appyappapp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print("$number");
    return MaterialApp( 
        home: Scaffold(appBar: AppBar(),
        body: Text("hello"), 
      )
    );
  }
}

class StateMainPage extends StatefulWidget{
  @override
  createState() => new MainPage();
}

class Appyappapp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Chuck Norris Jokes',
      home: StateMainPage()
    );
  }
}

class MainPage extends State<StateMainPage>{
  
  final formKey = GlobalKey<FormState>();

  Widget categoryDrop(BuildContext context){
    List<String> catList = ["any","explicit","dev","movie","food","celebrity","science","sport","political","religion","animal","history","music","travel","career","money","fashion"];

    List<DropdownMenuItem<String>> catDropdown = [];

    final _Font = const TextStyle(fontSize: 15.0);

    void initLeList(){
      catDropdown = [];
      String tempVal = "";
      for(String each in catList){
        if(each != "any"){
           tempVal = each;
        }
        catDropdown.add(DropdownMenuItem(child: Text("$each",style: _Font),value:"$tempVal"));
      }
    }

    initLeList();

    return Container(
      child: DropdownButton(items: catDropdown, onChanged:(value){
        setState(() {
                  catVal = value;
                });
      }, value: catVal)
    );
  }

  Widget randomButton(BuildContext context){
    return Container(child: RaisedButton(child: new Text("Random Joke"), padding: EdgeInsets.all(8.0),
      onPressed: (){
        final welcomeScreen = MaterialPageRoute(builder: (context) => RandomJokes(postJoke:fetchPostJoke()));
        Navigator.push(context, welcomeScreen);
      }, 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
      ),
      margin: const EdgeInsets.all(20.0));
  }

  Widget build(BuildContext context){
    
    return Form(key: formKey,
                child:Scaffold(
                  appBar: AppBar(title: Text("Chuck Norris Jokes"),),
                  body: Container(child:Center(child:Column(children: [categoryDrop(context),randomButton(context)],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center
                  ),
                  ),
                  margin: const EdgeInsets.all(32.0),
                ))
                );
  }
}




class RandomJokes extends StatelessWidget{
  Future<PostJoke> postJoke;

  RandomJokes({Key key, this.postJoke}) : super(key: key);

  Widget build(BuildContext context){

  final _biggerFont = TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold);
  final _catFont = TextStyle(fontSize: 15.0);

    return Scaffold(appBar: AppBar(title: Text("Category: ${catVal}"),),
    body:Container(child: FutureBuilder<PostJoke>(
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