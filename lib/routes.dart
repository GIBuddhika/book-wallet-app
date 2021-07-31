import 'package:flutter/material.dart';
import 'package:flutter_application_1/curved-navigation.dart';
import 'package:flutter_application_1/dashboard.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/dashboard':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => Dashboard(data: args),
          );
        } else {
          return _errorRoute();
        }
        break;
      case '/curved-navigation':
        return MaterialPageRoute(
          builder: (_) => CurvedNavigation(data: 'data'),
        );
        break;
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error page"),
        ),
        body: Center(
          child: Text('Error data'),
        ),
      );
    });
  }
}
