import 'package:field_king/Pages/login_page.dart';
import 'package:field_king/Pages/home_page.dart';
import 'package:field_king/Pages/splash_screen.dart';
import 'package:field_king/services/cons.dart';
import 'package:field_king/services/shared_preference.dart';
import 'package:field_king/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await getlocaldata();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = ScreenSize();
    screenSize.screensize(context)  ;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: (FirebaseAuth.instance.currentUser != null)
          ? HomePage()
          : (signup == true)
              ? LoginPage()
              : SplashScreen(),
      // home: HomePage(),
    );
  }
}
