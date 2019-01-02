import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String number = '1';
String typeVal = 'people';
String catVal = "";

Future<PostJoke> fetchPostJoke() async 
{
  final response = await http.get('https://api.chucknorris.io/jokes/random?category=$catVal');
  return PostJoke.fromJson(json.decode(response.body));
}

Future<Cats> fetchCats() async 
{
  final response = await http.get("https://api.chucknorris.io/jokes/categories");
  return Cats.fromJson(json.decode(response.body));
}

class Cats
{
  final List<String> catList;
  Cats({this.catList});
  factory Cats.fromJson(List<dynamic> json)
  {
    return(Cats(catList: json.cast<String>().toList()));
  }
}

class PostJoke
{
  final String value;
  PostJoke({this.value});
  factory PostJoke.fromJson(Map<String, dynamic> json) 
  {
    return PostJoke
    (
      value: json['value']
    );
  }

}

void main() => runApp(AppBild());


class StateMainPage extends StatefulWidget
{
  @override
  createState() => new MainPage();
}

class AppBild extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      title: 'Chuck Norris Jokes: Task 3',
      home: StateMainPage()
    );
  }
}

class CatPageState extends StatefulWidget
{
  @override
  createState() => new CatsPage();
}

class CatsPage extends State<CatPageState>
{
  Future<Cats> postCats = fetchCats();
  List<String> catscats;
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: Text("Select Category")),
      body: Container
      (
      child: FutureBuilder<Cats>
      (
        future: postCats, 
        builder: (context, daeta)
        {
          if(daeta.hasData)
          {
            List <String> catList = daeta.data.catList;
            return new Container
            (
              child: ListView.builder(
                itemCount: catList.length,
                itemBuilder: (context, index)
                {
                  String temp = "any";
                  if (catList[index] != 'any')
                  {
                    temp = catList[index];
                  }
                  return ListTile
                  (
                    title: Text("$temp"),
                    contentPadding: const EdgeInsets.all(15.0),
                    onTap: () 
                    {
                      catVal = temp;
                      Navigator.push(context,MaterialPageRoute(builder: (context) => RandomJokes(postJoke:fetchPostJoke())));
                      print("$catVal");
                    },
                  );
                },
              ) 
            );
          }
          else if(daeta.hasError)
          {
            return Container(child: Text("whoops"));
          } 
      },
    )
  ),
);
}
}

class MainPage extends State<StateMainPage>
{
  final formKey = GlobalKey<FormState>();
  Widget categoryDrop(BuildContext context)
  {
    return Container
    (
      child: RaisedButton
      (
        child: new Text("Categories"),
        padding: EdgeInsets.all(15.0),
        onPressed: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CatPageState()));
        },
        shape:BeveledRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      )
    );
  }

  Widget randomButton(BuildContext context)
  {
    return Container
    (
      child: RaisedButton
      (
        
        child: new Text("Random Joks"), 
        padding: EdgeInsets.all(15.0),
        onPressed: ()
        {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RandomJokes(postJoke:fetchPostJoke())));
        }, 
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20.0))
      ),
      margin: const EdgeInsets.all(20.0));
  }

  Widget build(BuildContext context)
  {
    return Form
    (
      key: formKey,
      child:Scaffold
      (
        appBar: AppBar(title: Text("Chuck Norris' API Task3"),),
        body: Container
        (
          child:Center
          (
            child:Column
            (
              children: [categoryDrop(context),randomButton(context)],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center
            ),
          ),
        margin: const EdgeInsets.all(32.0),
        )
      )
    );
  }
}




class RandomJokes extends StatelessWidget
{
  final Future<PostJoke> postJoke;
  RandomJokes({Key key, this.postJoke}) : super(key: key);
  Widget build(BuildContext context)
  {
    final _biggerFont = TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold);
    final _catFont = TextStyle(fontSize: 15.0);
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text("Category: $catVal"),
      ),
      body:Container
      (
        child: FutureBuilder<PostJoke>
        (
          future: postJoke,
          builder: (context, daeta)
          {
          if (daeta.hasData) 
          {
            return Container
            (
              child:Center
              (
                child:Column
                (
                  children:[Text("${daeta.data.value}",style: _biggerFont),
                            Text("Category:$catVal",style: _catFont,textAlign: TextAlign.left)],
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center, 
                ),
              ),
              margin: EdgeInsets.all(32.0)
            );
          }
          else if (daeta.hasError) 
          {
            return Text("Shit Just Got Real!");
          }
          return Center(child:LinearProgressIndicator());
          }
        )
      )
    );
  }
}