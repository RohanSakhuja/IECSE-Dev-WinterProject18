import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: Scaffold(
        body: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formkey,
        child: Column(
          children: <Widget>[
            Image.asset(
              'logo.png',
              height: 350.0,
              width: 350.0,
              fit: BoxFit.fill,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Email",
                labelText: "Email",
                contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Password",
                labelText: "Password",
                contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            ),
            ButtonTheme(
              minWidth: 400.0,
                height: 40.0,
                child: RaisedButton(
                  onPressed: () {
                    if (formkey.currentState.validate()) {

                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Processing Data')));
                    }
                  },
                  child: Text("Log In"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
            )
            )
          ],
        ));
  }
}
