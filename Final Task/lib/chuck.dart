import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

List<String> parse(List<dynamic> res) {
  List<String> cat = [];
  for (var i in res) {
    cat.add(i.toString());
  } 
  return cat;
}

Future<List<String>> categories() async {
  String url = "https://api.chucknorris.io/jokes/categories";
  var response = await http.get(url, 
  headers: {
    "content-type": "application/json"
  });
  if(response.statusCode == 200){
    var res = json.decode(response.body);
    return parse(res);
  } else {
    if(response.statusCode == 400){
      print("Server Error!");
    } else {
      print("Client Error!");
    }
  }
}

Future<String> joke(String cat) async {
  String url = "https://api.chucknorris.io/jokes/random?category=$cat";
  var response = await http.get(url, 
  headers: {
    "content-type": "application/json"
  });

  if(response.statusCode == 200){
    var res = json.decode(response.body);
    return res['value'];
  } else {
    if(response.statusCode == 400){
      print("Server Error!");
    } else {
      print("Client Error!");
    }
  }
}

class Jokes extends StatefulWidget {
  final String category;
  Jokes({this.category});
  @override
  JokesState createState() => new JokesState();
}

class JokesState extends State<Jokes> {
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.category),
        ),
        body: FutureBuilder(
          future: joke(widget.category),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return Center(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('" '+snapshot.data+' "', softWrap: true, textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0),),
                      ListTile(
                        title: Text("- Chuck Norris", textAlign: TextAlign.right,),
                      )
                    ],
                  )
                ),
              );
            } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      );
    }
}

class CategoryPage extends StatefulWidget {
  @override
  CategoryPageState createState() => new CategoryPageState();
}

class CategoryPageState extends State<CategoryPage> {
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Categories"),
        ),
        body: FutureBuilder(
          future: categories(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(snapshot.data[index]),
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Jokes(category: snapshot.data[index]))
                      );
                    },
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
    }
}