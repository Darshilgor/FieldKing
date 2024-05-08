import 'dart:async';

import 'package:field_king/Pages/home_page.dart';
import 'package:field_king/Pages/login_page.dart';
import 'package:field_king/Pages/singup_page.dart';
import 'package:field_king/controller/signup_login_controller.dart';
import 'package:field_king/firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  
}
