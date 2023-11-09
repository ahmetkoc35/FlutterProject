import 'package:flutter/material.dart';

import 'UDBConnection.dart';
import 'LogInPage.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUp>
{
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String usernameText = "";
  String passwordText = "";

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
              ElevatedButton(onPressed: getInputs, child: Text("Sign Up")),
            ]
        ),
      ),
    );
  }

  final databaseConnection = UserDatabaseConnection.instance;

  void getUsernameInput() async {
    usernameText = usernameController.text;
  }
  void getPasswordInput() async{
    passwordText = passwordController.text;
  }

  Future<void> getInputs() async
  {
    getUsernameInput();
    getPasswordInput();
    if(await databaseConnection.searchUser(usernameText) == true)
      {
        databaseConnection.insertUser(usernameText, passwordText);
        openLogIn();
      }
    else
      {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Username Already Exists"),
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

  void openLogIn() async
  {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

}