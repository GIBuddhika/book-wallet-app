import 'package:flutter/material.dart';

void main() {
  runApp(myapp());
}

class myapp extends StatelessWidget {
  // const myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter app title'),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: Center(
            child: Image.asset(
          "images/book.jpeg",
          height: double.infinity,
          fit: BoxFit.fill,
        )),
      ),
    );
  }
}
