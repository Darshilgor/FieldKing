import 'dart:convert';
import 'dart:math';

import 'package:field_king/services/function.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterlocalnotificationplugin =
      FlutterLocalNotificationsPlugin();

  void requestnotificationpermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted permession");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("user granted permession");
    } else {
      print("user denied permession");
    }
  }

  void ontokenrefresh() {
    messaging.onTokenRefresh.listen(
      (event) {
        event.toString();
      },
    );
    print('Token Refresh');
  }

  Future<String> getdevicetoken() async {
    String? token = await messaging.getToken();
    print('token $token');
    addUserData(token);
    return token!;
  }

  void firebaseinit(BuildContext context) {
    FirebaseMessaging.onMessage.listen(
      (message) {
        if (kDebugMode) {
          print(message.notification!.title.toString());
          print(message.notification!.body.toString());
        }
        // initlocalnotifications(context, message);
        shownotification(message);
      },
    );
  }

  // void backgroundfirebaseinit() {
  //   FirebaseMessaging.onMessage.listen(
  //     (message) {
  //       if (kDebugMode) {
  //         print(message.notification!.title.toString());
  //         print(message.notification!.body.toString());
  //       }
  //       shownotification(message);
  //     },
  //   );
  // }

  void initlocalnotifications(
      BuildContext context, RemoteMessage message) async {
    var androidinitializesettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosinitializesettings = DarwinInitializationSettings();
    var initiallizesetting = InitializationSettings(
      android: androidinitializesettings,
      iOS: iosinitializesettings,
    );

    // await flutterlocalnotificationplugin.initialize(initiallizesetting,
    //     onDidReceiveBackgroundNotificationResponse: (payload) {});
  }

  Future<void> shownotification(message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      'High Importance',
      importance: Importance.max,
      groupId: '1',
    );
    AndroidNotificationDetails androidnotificationdetail =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      icon: 'ic_launcher',
      channelDescription: 'Your Channel Description',
      importance: Importance.max,
      priority: Priority.max,
      ticker: 'ticker',
    );
    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    NotificationDetails notificationdetails = NotificationDetails(
      android: androidnotificationdetail,
      iOS: darwinNotificationDetails,
    );
    Future.delayed(Duration.zero, () {
      flutterlocalnotificationplugin.show(
        0,
        message.notification.title!.toString(),
        message.notification.body!.toString(),
        notificationdetails,
        payload: message.data['data'],
      );
    });
  }

  Future sendnotification() async {
    var data = {
      'to':
          'eBpaGJ43SAmF24g3uOCIQj:APA91bGMROFs8s78tWYYcsXBwWx_JouYMulkdGFVM0FWUYYZhBlvFE5l1Qy2IC3yuDdsKLHT9Fq5C82zzOeZDRbU6RrUKv3b2gvhku4cMrmfdmZP_5mTSwz-etO9IBxBp2C2v91s8kvE',
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
  }
}
