import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_data.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatelessWidget {
  final String data;

  Dashboard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardView(),
    );
  }
}

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int currentPage = 1;
  List<User> users = [];

  Future<bool> getUserData() async {
    final Uri uri = Uri.parse(
        'https://reqres.in/api/products?per_page=10&page=$currentPage');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = userDataFromJson(response.body);
      users = result.data;
      currentPage++;
      setState(() {});

      print(users.length);
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Dashboard1'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            final user = users[index];

            return ListTile(
              title: Text(user.name),
              tileColor: _getColorFromHex(user.color),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: users.length),
    );
  }

  //convert hex to integer
  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return Color(int.parse("0xffffffff"));
  }
}
