import 'package:flutter/material.dart';

import 'UDBConnection.dart';
import 'HomeScreen.dart';
import 'SignUp.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>  {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async{
    String username = usernameController.text;

    if (await searchUser(usernameController.text,passwordController.text) == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(username: username),
        ),
      );
      usernameController.clear();
      passwordController.clear();
    }
    else {
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

  void openSignUp()
  {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUp(),
      ),
    );
    usernameController.clear();
    passwordController.clear();
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
                  onPressed: openSignUp,
                  child: Text("Sign Up")),
            ],
          ),
        ),
      ),
    );
  }


  final databaseConnection = UserDatabaseConnection.instance;

  Future<bool> searchUser(String usernameToSearch, String passwordToSearch)
  {
    return databaseConnection.loginUser(usernameToSearch,passwordToSearch);
  }

  void seeUsers()
  {
    databaseConnection.fetchUsers();
  }
}