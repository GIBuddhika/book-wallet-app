import 'dart:ffi';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/dashboard.dart';
import 'package:flutter_application_1/model/user_data.dart';
import 'package:flutter_application_1/user-details.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CurvedNavigation extends StatelessWidget {
  final String data;

//     PersistentTabController _controller;

// _controller = PersistentTabController(initialIndex: 0);

  CurvedNavigation({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      home: CurvedNavigationView(),
    );
  }
}

class CurvedNavigationView extends StatefulWidget {
  // const CurvedNavigationView({Key? key}) : super(key: key);

  @override
  _CurvedNavigationViewState createState() => _CurvedNavigationViewState();
}

class _CurvedNavigationViewState extends State<CurvedNavigationView> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: false, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [
      Dashboard(data: 'text'),
      UserDetails(),
      UserDetails(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          title: ("Home"),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.orangeAccent),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.settings,
          color: Colors.white,
        ),
        title: ("Settings"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.orangeAccent,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(),
        onPressed: (context1) {
          _showModal(context);
        },
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: ("Settings2"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.orangeAccent,
      ),
    ];
  }

  Future _showModal(context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => buildSheet(),
    );
  }

  Widget makeDismissable({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(onTap: () {}, child: child),
      );

  Widget buildSheet() => makeDismissable(
        child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          builder: (_, controller) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: EdgeInsets.all(20),
            child: ListView(
              controller: controller,
              children: [
                Text('test'),
                Text('test1'),
                Text('test2'),
              ],
            ),
          ),
        ),
      );
}

class _CurvedNavigationViewState1 extends State<CurvedNavigationView> {
  int _page = 1; //set defualt page when loading

  final _pageOption = [
    UserDetails(),
    Dashboard(data: 'THIS IS TEST'),
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
            if (index == 2) {
              _showModal(context);
            } else {
              _page = index;
            }
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

  Future _showModal(context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => buildSheet(),
    );
  }

  Widget makeDismissable({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(onTap: () {}, child: child),
      );

  Widget buildSheet() => makeDismissable(
        child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          builder: (_, controller) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: EdgeInsets.all(20),
            child: ListView(
              controller: controller,
              children: [
                Text('test'),
                Text('test1'),
                Text('test2'),
              ],
            ),
          ),
        ),
      );
}
