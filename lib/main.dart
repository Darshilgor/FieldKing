import 'dart:async';

import 'package:field_king/Pages/home_page.dart';
import 'package:field_king/Pages/login_page.dart';
import 'package:field_king/Pages/singup_page.dart';
import 'package:field_king/firebase_options.dart';
import 'package:field_king/services/get_storage/get_storage.dart';
import 'package:field_king/services/notification/notification_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

@pragma('vm:entry-point')
Future<void> backgroundNotificationHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  await Firebase.initializeApp();

  NotificationServices notificationservices = NotificationServices();
  notificationservices.shownotification(message);
}

Future main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseAppCheck.instance.activate();
  FirebaseMessaging.onBackgroundMessage(backgroundNotificationHandler);
  await GetStorage.init();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // final notificationAppLaunchDetails =
  //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  // if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
  //   final message = notificationAppLaunchDetails!.notificationResponse;
  // }

  runApp(const MyApp());
}

// @pragma('vm:entry-point')
// Future<void> _firebasemessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GetStorageClass storage = GetStorageClass();
  @override
  void initState() {
    super.initState();
    GetStorageClass.initGetStorage();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Field King',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: (GetStorageClass.readSignup() == false)
          ? SignUpPage()
          : (GetStorageClass.readSignup() == true &&
                  FirebaseAuth.instance.currentUser != null)
              ? HomePage()
              : LoginPage(),
    );
  }
}
