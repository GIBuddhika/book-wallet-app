import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/dashboard.dart';
import 'package:flutter_application_1/model/user_data.dart';
import 'package:flutter_application_1/user-details.dart';
import 'package:flutter_application_1/welcome.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CurvedNavigation extends StatelessWidget {
  final String data;

  CurvedNavigation({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CurvedNavigationView(),
    );
  }
}

class CurvedNavigationView extends StatefulWidget {
  const CurvedNavigationView({Key? key}) : super(key: key);

  @override
  _CurvedNavigationViewState createState() => _CurvedNavigationViewState();
}

class _CurvedNavigationViewState extends State<CurvedNavigationView> {
  int _page = 1; //set defualt page when loading

  final _pageOption = [
    UserDetails(),
    Dashboard(data: 'THIS IS TEST'),
    welcome(),
  ];

  int currentPage = 1;
  List<User> users = [];
  late int totalPages;
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.grey.shade100,
        index: 1,
        items: <Widget>[
          Icon(Icons.compare_arrows, size: 30),
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
        ],
        onTap: (int index) {
          setState(() {
            _page = index;
          });
        },
        animationCurve: Curves.fastLinearToSlowEaseIn,
        color: Colors.amber,
        height: 50,
      ),
      backgroundColor: Colors.grey.shade100,
      body: _pageOption[_page],
    );
  }
}
