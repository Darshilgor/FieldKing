import 'dart:convert';

import 'package:field_king/services/notification/notification_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  notification_Services notificationservices = notification_Services();

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
