import 'package:flutter/material.dart';
import 'package:flutter_application_1/dashboard.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:flutter_application_1/welcome.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: firstPage(),
  ));
}

class firstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: welcome(),
      initialRoute: '/',
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
