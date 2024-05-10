import 'package:field_king/services/function.dart';
import 'package:field_king/services/notification/notification_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NotificationServices notificationservices = NotificationServices();

  @override
  void initState() {
    super.initState();

    notificationservices.requestnotificationpermission();
    notificationservices.firebaseinit(context);
    notificationservices.ontokenrefresh();

    notificationservices.getdevicetoken().then(
          (value) => print(
            value,
          ),
        );
    sendnotification();
    // addUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
        ),
      ),
      body: InkWell(
          onTap: () {
            FirebaseAuth.instance.signOut();
          },
          child: Text('logout')),
    );
  }
}
