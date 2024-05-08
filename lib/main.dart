import 'dart:async';
import 'dart:convert';

import 'package:field_king/Pages/home_page.dart';
import 'package:field_king/Pages/login_page.dart';
import 'package:field_king/Pages/singup_page.dart';
import 'package:field_king/controller/signup_login_controller.dart';
import 'package:field_king/firebase_options.dart';
import 'package:field_king/services/notification/notification_services.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate();
  FirebaseMessaging.onBackgroundMessage(_firebasemessagingBackgroundHandler);

  // await getlocaldata();
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebasemessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SignupLoginController controller = Get.put(SignupLoginController());
  NotificationServices notificationservices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationservices.requestnotificationpermission();
    notificationservices.forgroundMessage();
    notificationservices.firebaseinit(context);
    // notificationservices.setupInteractMessage(context);
    notificationservices.ontokenrefresh();

    notificationservices.getdevicetoken().then((value) {
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
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
      home: Obx(
        () {
          if (controller.isSignup == true &&
              FirebaseAuth.instance.currentUser != null) {
            return HomePage();
          } else if (controller.isSignup == true &&
              FirebaseAuth.instance.currentUser == null) {
            return LoginPage();
          } else {
            return SignUpPage();
          }
        },
      ),
    );
  }

  Future sendnotification() async {
    notificationservices.getdevicetoken().then(
      (value) async {
        print('value is');
        print(value);
        var data = {
          'to': value.toString(),
          'priority': 'high',
          'notification': {
            'title': 'Gor',
            'body': 'Darshil',
          }
        };
        await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Authorization':
                'Key=AAAAQpaz38E:APA91bFNslLR_Im-MJL8kOqCc9wK3rnajD9rURZaXZAaq-VA-YCj_JQHfW8eaRlUlCM8g_bDXgSiPlbWJW_SM9buSK08Ed4l_9vEc1e5DQsYtybSb_iCjSHhwO8U7n79708It_6QsqJX'
          },
        );
      },
    );
  }
}
