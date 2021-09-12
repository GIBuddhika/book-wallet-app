import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/dashboard.dart';
import 'package:flutter_application_1/model/FABBottomAppBarItem.dart';
import 'package:flutter_application_1/user-details.dart';

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
  @override
  _CurvedNavigationViewState createState() => _CurvedNavigationViewState();
}

class _CurvedNavigationViewState extends State<CurvedNavigationView> {
  int pageId = 1;

  showViews() {
    print('page id:');
    print(pageId);
    if (pageId == 1) {
      return Dashboard(
        data: 'sdfsd',
      );
    } else {
      return UserDetails();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showModal(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
      bottomNavigationBar: FABBottomAppBar(
        onTabSelected: (int a) {
          setState(() {
            this.pageId = a;
          });
        },
        notchedShape: CircularNotchedRectangle(),
        items: [
          FABBottomAppBarItem(iconData: Icons.menu, text: 'This'),
          FABBottomAppBarItem(iconData: Icons.layers, text: 'Is'),
          FABBottomAppBarItem(iconData: Icons.dashboard, text: 'Bottom'),
          FABBottomAppBarItem(iconData: Icons.info, text: 'Bar'),
        ],
      ),
      body: showViews(),
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
