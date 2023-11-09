import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {

runApp(MyApp());
}

class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
home: LoginPage(),
);
}
}

class LoginPage extends StatefulWidget {
@override
_LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

void login() {
String username = usernameController.text;
String password = passwordController.text;

    if (username == "ahmet" && password == "123") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(username: username.toUpperCase()),
        ),
      );
      usernameController.clear();
      passwordController.clear();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Username or Password Is Wrong"),
            actions: [
              ElevatedButton(
                child: Text("Okay"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
}

void signup()
{

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUp(),
      ),
    );
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text("Welcome"),
),
body: Center(
child: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: <Widget>[
TextField(
controller: usernameController,
decoration: InputDecoration(labelText: "Username"),
),
TextField(
controller: passwordController,
decoration: InputDecoration(labelText: "Password"),
obscureText: true,
),
SizedBox(height: 20.0),
ElevatedButton(
onPressed: login,
child: Text("Log In"),
),
SizedBox(height: 20.0),
ElevatedButton(
onPressed: signup,
child: Text("Sign Up")),
],
),
),
),
);
}
}

class HomeScreen extends StatelessWidget {
final String username;

HomeScreen({required this.username});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text("Welcome, $username"),
),
body: Center(
child: Text("Main Screen"),
),
);
}
}

void backToLogIn()
{
_LoginPageState createState() => _LoginPageState();
}

class SignUp extends StatelessWidget {

SignUp();

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text("Welcome"),
),
body: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: <Widget>[
TextField(
controller: usernameController,
decoration: InputDecoration(labelText: "Username"),
),
TextField(
controller: passwordController,
decoration: InputDecoration(labelText: "Password"),
obscureText: true,
),
ElevatedButton(onPressed: backToLogIn, child: Text("Sign Up")),
]
),
),
);
}
}
