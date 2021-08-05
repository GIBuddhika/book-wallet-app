import 'package:flutter/material.dart';
import 'package:flutter_application_1/dashboard.dart';
import 'package:flutter_application_1/local_auth.dart';
import 'package:flutter_application_1/sign-in.dart';

class welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.orangeAccent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.coffee_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        'WELCOME',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 30, top: 30),
                    child: Center(
                        child: Image.asset(
                      "images/welcome.png",
                      width: double.infinity,
                      fit: BoxFit.fill,
                    )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.vpn_key,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignIn()),
                          );
                          print("Outlined button clicked.");
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.book_online_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        onPressed: () async {
                          final isAuthenticated =
                              await LocalAuth.authenticate();
                          print(
                              'isAuthenticated ' + isAuthenticated.toString());
                          if (isAuthenticated) {
                            Navigator.of(context).pushNamed(
                              '/curved-navigation',
                              arguments: 'This is text from sign in page',
                            );
                          }
                        },
                        child: Text("Login"),
                        style: TextButton.styleFrom(
                          primary: Colors.orangeAccent,
                          backgroundColor: Colors.white,
                          minimumSize: Size(
                            200.0,
                            40,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
