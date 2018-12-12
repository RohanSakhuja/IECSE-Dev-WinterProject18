import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
}

class SavedScreen extends StatelessWidget {
  Set<WordPair> savedSet;

  final _biggerFont = const TextStyle(fontSize: 19.0);

  SavedScreen(Set savedSet ){
    this.savedSet = savedSet;
  }

  @override
  Widget build(BuildContext context) {

    final Iterable<ListTile> tiles = savedSet.map(
          (WordPair pair) {
            return new ListTile(
              title: new Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => NamedPage(pair)));
              }
            );
          }
        );
    
    final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
 
    return new Scaffold( 
          appBar: new AppBar(
            title: const Text('Saved Names')
          ),
          body: new ListView(children: divided), 
        );
  }
}

class RandomWordsState extends State<RandomWords> {
  
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();

  final _biggerFont = const TextStyle(fontSize: 19.0);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool _alreadySaved =  _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        _alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: _alreadySaved? Colors.red: null
      ),
      onTap: (){
        setState(() {
                  if (_alreadySaved){
                    _saved.remove(pair);
                  }else{
                    _saved.add(pair);
                  }
                });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Namer - Pick a Name before you change the world'),
        actions: <Widget>[ 
          new IconButton(icon: const Icon(Icons.list), onPressed:()
          {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SavedScreen(_saved)));
          }
          ) ],
      ),
      body: _buildSuggestions(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}


class NamedPage extends StatelessWidget {
  WordPair pair;

  final _biggerFont = TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold);  
  final _smallerFont = TextStyle(fontSize: 18.0);

  NamedPage(WordPair pair){
    this.pair = pair;
  }

  Widget detailScreen(){

    String name1 = "How does this website sound to you?"; 
    String name2 = "https://www.${pair.asLowerCase}.com ";
    String email = "Your email will be:";  
    String email2 = "ceo@${pair.asLowerCase}.com";
    
    Widget websiteName1 = Center(child: Text(name1,style: _smallerFont,softWrap: true));
    Widget emailName1 = Center(child:Text(email, style: _smallerFont, softWrap: true));
    Widget websiteName2 = Center(child: Text(name2,style: _biggerFont,softWrap: true));
    Widget emailName2 = Center(child:Text(email2, style: _biggerFont, softWrap: true));

    return Center(child: ListView(
      children: [websiteName1,websiteName2,emailName1,emailName2]
    ));
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(appBar: AppBar(title: Text(pair.asPascalCase)),
    body: detailScreen()
    );

  }

}