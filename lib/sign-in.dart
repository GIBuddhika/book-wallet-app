import 'package:flutter/material.dart';
import 'package:flutter_application_1/dashboard.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade100,
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              '/curved-navigation',
              arguments: 'This is text from sign in page',
            );
          },
          child: Text("Sign in"),
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
      ),
    );
  }
}
