// import 'dart:convert';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:push_notification_api/view/empty_page/empty_page.dart';
// import 'package:push_notification_api/view/home_page/home_page.dart';
//
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   // Subscribe to a topic
//   subscribeToTopic("Abhi");
//
//   FirebaseMessaging.instance.getToken().then((value){
//     print("getToken : $value");
//   });
//
//   // if application is in background then it will work.
//   FirebaseMessaging.onMessageOpenedApp.listen(
//       (RemoteMessage message) async {
//        print("onMessageOpenedApp : $message");
//        Navigator.pushNamed(navigatorKey.currentState!.context, "/push-page",
//          arguments:
//          {"message", json.encode(message.data)},
//          );
//       }
//   );
//
//   // if App is closed or terminiated
//   FirebaseMessaging.instance.getInitialMessage().then(
//       (RemoteMessage? message){
//         if(message != null){
//           Navigator.pushNamed(navigatorKey.currentState!.context, "/push-page",
//             arguments: {"message", json.encode(message.data)},
//           );
//         }
//       }
//   );
//
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//   runApp(const MyApp());
// }
//
// Future<void> _firebaseMessagingBackgroundHandler (RemoteMessage message) async{
//      await Firebase.initializeApp();
//      print("_firebaseMessagingBackgroundHandler : $message");
// }
//
// void subscribeToTopic(String topic) async {
//   await FirebaseMessaging.instance.subscribeToTopic(topic);
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       navigatorKey: navigatorKey,
//       routes: {
//         '/': ((context) => const EmptyPage()), // Define '/' in routes instead of home
//         '/push_page': ((context) => HomePage()),
//       },
//     );
//   }
// }
//





import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:push_notification_api/view/empty_page/empty_page.dart';
import 'package:push_notification_api/view/home_page/home_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Subscribe to a topic
  subscribeToTopic("Abhi");

  FirebaseMessaging.instance.getToken().then((value) {
    print("getToken : $value");
  });

  // Listen for messages when the app is in the foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("onMessage: ${message.notification?.title}, ${message.notification?.body}");
    _showNotificationDialog(message);
  });

  // If the application is in the background
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("onMessageOpenedApp : $message");
    _navigateToPushPage(message);
  });

  // If App is closed or terminated
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      _navigateToPushPage(message);
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("_firebaseMessagingBackgroundHandler : $message");
}

void subscribeToTopic(String topic) async {
  await FirebaseMessaging.instance.subscribeToTopic(topic);
}

void _showNotificationDialog(RemoteMessage message) {
  final context = navigatorKey.currentState?.context;
  if (context != null) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message.notification?.title ?? "Notification"),
          content: Text(message.notification?.body ?? "You have a new notification."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

void _navigateToPushPage(RemoteMessage message) {
  final context = navigatorKey.currentState?.context;
  if (context != null) {
    Navigator.pushNamed(
      context,
      "/push_page",
      arguments: {"message": json.encode(message.data)},
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      routes: {
        '/': ((context) => const EmptyPage()), // Define '/' in routes instead of home
        '/push_page': ((context) => HomePage()),
      },
    );
  }
}
