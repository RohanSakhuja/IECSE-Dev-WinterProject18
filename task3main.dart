import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String number = '1';
String typeVal = 'values';
String catVal = "";

Future<PostingJoke> fetchPostingJoke() async {
  final response =
  await http.get('https://api.chucknorris.io/jokes/random?category=$catVal');

  return PostingJoke.fromJson(json.decode(response.body));

}

Future<Category> fetchCategory() async {
  final response =
  await http.get("https://api.chucknorris.io/jokes/categories");

  return Category.fromJson(json.decode(response.body));
}

class Category{
  final List<String> catList;

  Category({this.catList});

  factory Category.fromJson(List<dynamic> json){
    return(Category(catList: json.cast<String>().toList()));
  }
}

class PostingJoke{
  final String value;

  PostingJoke({this.value});

  factory PostingJoke.fromJson(Map<String, dynamic> json) {
    return PostingJoke(
        value: json['value']
    );
  }

}

void main() => runApp(app());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print("$number");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

class app extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Chuck Norris Jokes',
        home: StateMainPage()
    );
  }
}

class CatPageState extends StatefulWidget{
  @override
  createState() => new CatsPage();
}

class CatsPage extends State<CatPageState>{

  Future<Category> postCats = fetchCategory();

  List<String> category;

  //List<DropdownMenuItem<String>> dropcats = [];


  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text("Categories"),),
      body: Container(
          child: FutureBuilder<Category>(future: postCats,
            builder: (context, snapshot){
              if(snapshot.hasData){

                List <String> catList = snapshot.data.catList;


                return Container(
                    child: ListView.builder(
                      itemCount: catList.length,
                      itemBuilder: (context, index){
                        String temp = "";
                        if (catList[index] != 'any'){
                          temp = catList[index];
                        }
                        return ListTile(title: Text("$temp"),
                          contentPadding: const EdgeInsets.all(10.0),
                          onTap: () {
                            catVal = temp;
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => RandomJokes(postingJoke:fetchPostingJoke()))
                            );
                            print("$catVal");
                          },
                        );
                      },
                    )
                );
              }else if(snapshot.hasError){
                return Container(child: Text("something went wrong :("));
              }
              return Center(child:CircularProgressIndicator());

            }

            ,
          )
      ),
    );
  }

}


class RandomJokes extends StatelessWidget {
  Future<PostingJoke> postingJoke;

  RandomJokes({Key key, this.postingJoke}) : super(key: key);

  Widget build(BuildContext context) {
    final _biggerFont = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
    final _catFont = TextStyle(fontSize: 15.0);

    return Scaffold(appBar: AppBar(title: Text(" ${catVal}"),),
        body: Container(child: FutureBuilder<PostingJoke>(
            future: postingJoke,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(child: Center(child: Column(children: [
                  Text("${snapshot.data.value}", style: _biggerFont),
                  Text("$catVal", style: _catFont, textAlign: TextAlign.left)
                ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                ),
                    margin: EdgeInsets.all(32.0)
                );
              } else if (snapshot.hasError) {
                return Text("something went wrong :(");
              }
              return Center(child: CircularProgressIndicator());
            }
        )
        )
    );
  }
}

// ignore: expected_class_member
class MainPage extends State<StateMainPage>{

  final formKey = GlobalKey<FormState>();

  Widget categoryDrop(BuildContext context){

    final _Font = const TextStyle(fontSize: 15.0);

    return Container(
        child: RaisedButton(
          child: new Text("Categories"),
          padding: EdgeInsets.all(8.0),
          onPressed: (){
            final catPage = MaterialPageRoute(builder: (context) => CatPageState());
            Navigator.push(context, catPage);
          },
          shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        )
    );
  }

  Widget randomButton(BuildContext context){
    return Container(child: RaisedButton(child: new Text("Random Joke"), padding: EdgeInsets.all(8.0),
        onPressed: (){
          final welcomeScreen = MaterialPageRoute(builder: (context) => RandomJokes(postingJoke:fetchPostingJoke()));
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
