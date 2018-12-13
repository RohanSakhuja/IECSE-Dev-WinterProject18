import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(Task1());

class Task1 extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      title: 'Task_1_Part_2:Startup Name Generator',
      theme: new ThemeData
      (
        primaryColor: Colors.white,
      ),
      home: new RndWords(),
    );
  }
}

class RndWords extends StatefulWidget
{
  @override
  RndWordsState createState() => new RndWordsState();
}

class RndWordsState extends State<RndWords> 
{
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final _font = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context)
  {
    return new Scaffold
    (
      appBar: new AppBar
      (
        title: const Text('Task_1_Part_2:Startup Name Generator'),
        actions: <Widget>
        [
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() 
  {
    return new ListView.builder
    (
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext _context, int i) 
      {
        if (i.isOdd) 
        {
          return Divider();
        }
        final index = i ~/ 2;
        if (index >= _suggestions.length) 
        {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }  
    );
  }

  Widget _buildRow(WordPair pair) 
  {
    final bool alreadySaved = _saved.contains(pair);

    return new ListTile
    (
      title: new Icon
      (
        alreadySaved ? Icons.blur_on : Icons.blur_off,
        color: alreadySaved ? Colors.black : null,
      ),
      trailing: new Text
      (
        pair.asPascalCase,
        style: _font,
      ),
      onTap: () 
      {
        setState
        (
          ()
          {
            if (alreadySaved) 
            {
              _saved.remove(pair);
            }
            else
            {
              _saved.add(pair);
            }
          }
        );
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _font,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
                context: context,
                tiles: tiles,
              )
              .toList();
          return new Scaffold(
            appBar: new AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
}