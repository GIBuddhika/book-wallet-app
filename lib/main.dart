import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/curved-navigation.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:flutter_application_1/sign-in.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(
    MaterialApp(
      title: 'Navigation Basics',
      home: FirstPage(),
      theme: ThemeData(
        // primaryColor: Colors.lightGreen,
        // accentColor: Colors.orange[600],
        // indicatorColor: Colors.yellow,
        // focusColor: Colors.yellow,
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Colors.yellow,
        ),
      ),

      // home: CurvedNavigation(data: 'data'),
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarDividerColor: Colors.transparent,
  ));
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPageScreen(),
      // initialRoute: '/',
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

class FirstPageScreen extends StatefulWidget {
  const FirstPageScreen({Key? key}) : super(key: key);

  @override
  FirstPageScreenState createState() => FirstPageScreenState();
}

class FirstPageScreenState extends State<FirstPageScreen> {
  @override
  void initState() {
    super.initState();
    checkAuth();
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Notification"),
              content: Text(event.notification!.body!),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Notification"),
              content: Text(message.notification!.body!),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }

  final storage = FlutterSecureStorage();

  Future<bool> checkAuth() async {
    // await storage.write(key: 'token', value: 'token1');
    String? token = await storage.read(key: 'token');
    // await storage.deleteAll();
    print(token);
    if (token != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CurvedNavigation(data: 'data')),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
      );
    }
    return true;
  }

  @override
  // Widget build(BuildContext context) {
  //   return Container();
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                print(1);
                flutterLocalNotificationsPlugin.show(
                    0,
                    'testing',
                    'test text',
                    NotificationDetails(
                      android: AndroidNotificationDetails(
                        channel.id,
                        channel.name,
                        channel.description,
                        importance: Importance.high,
                        color: Colors.blue,
                        playSound: true,
                        icon: '@mipmap/launcher_icon',
                      ),
                    ));
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
          ],
        ),
      ),
    );
  }
}
