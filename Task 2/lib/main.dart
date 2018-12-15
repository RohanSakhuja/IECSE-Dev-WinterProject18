import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Login Page';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body:
        MyCustomForm(),
      ),
    );
  }
}

// Create a Form Widget
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class MyCustomFormState extends State<MyCustomForm> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
       Center(
         child: new Image.asset('logo.png',
             width: 250.0,
           height: 250,
           //double height: 2.0,
       ),
       ),
      Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
      /*new Container(
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
        border: new Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(40.0)),
      ),*/

      child: TextFormField(
            decoration: InputDecoration(
                labelText: 'Enter your username',
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
            },
          ),
      ),




    Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
      /*new Container(
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          border: new Border.all(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(40.0)),
        ),*/

        child: TextFormField(
          decoration: InputDecoration(
              labelText: 'Enter your password',
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
          },
        ),
      ),

      new Container(
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          /* border: new Border.all(
    color: Colors.black,
    width: 1.0,
    ),*/
          borderRadius: const BorderRadius.all(Radius.circular(40.0)),
        ),

        child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
            child: RaisedButton(
             onPressed: () {
                if (_formKey.currentState.validate()) {

                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
            color: Theme.of(context).accentColor,

              child: Text('Submit'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
            ),
          ),
    ),
    ),
    ],
      ),
    );

  }
}
