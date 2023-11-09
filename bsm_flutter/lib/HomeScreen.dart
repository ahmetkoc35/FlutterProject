import 'package:flutter/material.dart';

import 'UDBConnection.dart';


class HomeScreen extends StatelessWidget {
  final String username;

  TextEditingController todaysMileInput = TextEditingController();

  HomeScreen({required this.username});

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Welcome, $username"),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: todaysMileInput,
                    decoration: InputDecoration(labelText: "How Many Miles Did You Run Today"),
                    obscureText: false,
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      enter(double.parse(todaysMileInput.text));
                    },
                    child: Text("Enter"),
                  ),
                  SizedBox(height: 20.0),
                  FutureBuilder<double?>(
                    future: getMiles(username),
                    builder: (BuildContext context, AsyncSnapshot<double?> snapshot) {
                      return Text("Total Miles: ${snapshot.data ?? getMiles(username)}");
                    },
                  ),
                ],
              ),
            )
          ),
        );
      }


  final databaseConnection = UserDatabaseConnection.instance;

  Future<double?> getMiles(String username) async
  {
    return await databaseConnection.getTotalMiles(username);
  }

  Future<void> enter(double todaysMile) async
  {
    await databaseConnection.insertRun(username, todaysMile);
    print("Miles Sent!-------------------------------------------" + todaysMile.toString());
  }
}