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

    notificationservices.sendnotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
        ),
      ),
      body: Column(
        children: [
          InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text('logout')),
          InkWell(
              onTap: () {
                notificationservices.requestnotificationpermission();
                notificationservices.firebaseinit(context);
                notificationservices.ontokenrefresh();

                notificationservices.sendnotification();
              },
              child: Text('send notificaion')),
        ],
      ),
    );
  }
}
