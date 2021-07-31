import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_data.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  late int totalPages;
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  Future<bool> getUserData({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (currentPage > totalPages) {
        refreshController.loadNoData();
        return true;
      }
    }

    final Uri uri = Uri.parse(
        'https://reqres.in/api/products?per_page=5&page=$currentPage');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = userDataFromJson(response.body);
      totalPages = result.totalPages;
      if (isRefresh) {
        users = result.data;
      } else {
        users.addAll(result.data);
      }
      currentPage++;
      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Scrollbar(
        child: SmartRefresher(
          controller: refreshController,
          header: WaterDropMaterialHeader(
            backgroundColor: Colors.orangeAccent.shade100,
          ),
          enablePullUp: true,
          onRefresh: () async {
            final result = await getUserData(isRefresh: true);
            if (result) {
              refreshController.refreshCompleted();
            } else {
              refreshController.refreshFailed();
            }
          },
          onLoading: () async {
            final result = await getUserData();
            if (result) {
              refreshController.loadComplete();
            } else {
              refreshController.loadFailed();
            }
          },
          child: ListView.separated(
              itemBuilder: (context, index) {
                final user = users[index];

                return ListTile(
                  title: Text(user.name),
                  tileColor: _getColorFromHex(user.color),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: users.length),
        ),
      ),
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
