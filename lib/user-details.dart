import 'package:flutter/material.dart';
import 'package:flutter_application_1/sign-in.dart';
import 'package:geolocator/geolocator.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  String latData = "";
  String longData = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  getCurrentLocation() async {
    final geoposition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    setState(() {
      latData = geoposition.latitude.toString();
      longData = geoposition.longitude.toString();
      print(latData);
      print(longData);
      double distanceInMeters = Geolocator.distanceBetween(
          geoposition.latitude, geoposition.longitude, 6.35, 81.55);
      print(distanceInMeters);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      // appBar: AppBar(
      //   title: Text("Dashboard"),
      //   backgroundColor: Colors.yellowAccent.shade700,
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Latitude' + latData),
            Text('Longitude' + longData),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                );
              },
              child: Text("User 1"),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: BorderSide(
                  color: Colors.orangeAccent,
                  width: 2.0,
                  style: BorderStyle.solid,
                ),
                primary: Colors.orangeAccent,
                minimumSize: Size(
                  200.0,
                  40,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                );
              },
              child: Text("User 2"),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: BorderSide(
                  color: Colors.orangeAccent,
                  width: 2.0,
                  style: BorderStyle.solid,
                ),
                primary: Colors.orangeAccent,
                minimumSize: Size(
                  200.0,
                  40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class UserDetails extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       // appBar: AppBar(
//       //   title: Text("Dashboard"),
//       //   backgroundColor: Colors.yellowAccent.shade700,
//       // ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             OutlinedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SignIn()),
//                 );
//               },
//               child: Text("User 1"),
//               style: OutlinedButton.styleFrom(
//                 backgroundColor: Colors.transparent,
//                 side: BorderSide(
//                   color: Colors.orangeAccent,
//                   width: 2.0,
//                   style: BorderStyle.solid,
//                 ),
//                 primary: Colors.orangeAccent,
//                 minimumSize: Size(
//                   200.0,
//                   40,
//                 ),
//               ),
//             ),
//             OutlinedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SignIn()),
//                 );
//               },
//               child: Text("User 2"),
//               style: OutlinedButton.styleFrom(
//                 backgroundColor: Colors.transparent,
//                 side: BorderSide(
//                   color: Colors.orangeAccent,
//                   width: 2.0,
//                   style: BorderStyle.solid,
//                 ),
//                 primary: Colors.orangeAccent,
//                 minimumSize: Size(
//                   200.0,
//                   40,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
