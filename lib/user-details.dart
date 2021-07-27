import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/sign-in.dart';

class UserDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.shade400,
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.yellowAccent.shade700,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                );
              },
              child: Text("User 1"),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                  style: BorderStyle.solid,
                ),
                primary: Colors.white,
                minimumSize: Size(
                  200.0,
                  40,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                );
              },
              child: Text("User 2"),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                  style: BorderStyle.solid,
                ),
                primary: Colors.white,
                minimumSize: Size(
                  200.0,
                  40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
