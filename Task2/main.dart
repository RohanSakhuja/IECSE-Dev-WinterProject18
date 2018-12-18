import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.blue,
      ),
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: <Widget>[
            Container(
            margin: const EdgeInsets.all(10.0),
            child:new Align(
            alignment: Alignment.center,
            child: new Image.asset('assets/logo.png'),
            ),
            ),
            Container(
            margin: const EdgeInsets.all(10.0),
            child:SizedBox(
            width:350,
            child:TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: new InputDecoration(
            border: new OutlineInputBorder(
            borderRadius: new BorderRadius.all(
            const Radius.circular(30.0),
            ),
            ),
            labelText: 'Email',
            ),
            ),
            ),
            ),
            Container(
            margin: const EdgeInsets.all(10.0),
            child:SizedBox(
            width: 350,
            child:TextFormField(
            keyboardType: TextInputType.text,
            decoration: new InputDecoration(
            border: new OutlineInputBorder(
            borderRadius: new BorderRadius.all(
            const Radius.circular(30.0),
            ),
            ),
            labelText: 'Password'
            ),
            ),
            ),
            ),
            new Container(
            width:350,
            height:60,
            padding: EdgeInsets.all(8.0),
            child:
            RaisedButton(
            onPressed: (){
            print('Button Pressed');
            },
            color: Colors.blue,
            elevation: 10.0,
            textColor: Colors.white,
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            padding: EdgeInsets.all(8.0),
            child: new Text('Log In'),
          ),
          ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
