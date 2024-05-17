// import 'dart:convert';
// import 'dart:math';

// import 'package:app_settings/app_settings.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;

// class NotificationServices {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin flutterlocalnotificationplugin =
//       FlutterLocalNotificationsPlugin();

//   void requestnotificationpermission() async {
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       criticalAlert: true,
//       provisional: true,
//       sound: true,
//     );
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print("user granted permession");
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       AppSettings.openAppSettings(
//         type: AppSettingsType.notification,
//       );
//     } else {
//       AppSettings.openAppSettings(type: AppSettingsType.notification);
//     }
//   }

//   void ontokenrefresh() {
//     messaging.onTokenRefresh.listen(
//       (event) {
//         event.toString();
//       },
//     );
//     print('Token Refresh');
//   }

//   Future<String> getdevicetoken() async {
//     String? token = await messaging.getToken();
//     print('token $token');
//     // addUserData(token);
//     return token!;
//   }

//   void firebaseinit(BuildContext context) {
//     FirebaseMessaging.onMessage.listen(
//       (message) {
//         if (kDebugMode) {
//           print(message.notification!.title.toString());
//           print(message.notification!.body.toString());
//         }
//         // initlocalnotifications(context, message);
//         shownotification(message);
//       },
//     );
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       // Handle tap event here
//       print('Notification tapped: ${message.notification!.title}');
//       // You can navigate to a specific screen or perform any action here
//     });
//   }

//   // void backgroundfirebaseinit() {
//   //   FirebaseMessaging.onMessage.listen(
//   //     (message) {
//   //       if (kDebugMode) {
//   //         print(message.notification!.title.toString());
//   //         print(message.notification!.body.toString());
//   //       }
//   //       shownotification(message);
//   //     },
//   //   );
//   // }

//   void initlocalnotifications(
//       BuildContext context, RemoteMessage message) async {
//     var androidinitializesettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     var iosinitializesettings = DarwinInitializationSettings();
//     var initiallizesetting = InitializationSettings(
//       android: androidinitializesettings,
//       iOS: iosinitializesettings,
//     );

//     // await flutterlocalnotificationplugin.initialize(initiallizesetting,
//     //     onDidReceiveBackgroundNotificationResponse: (payload) {});
//   }

//   Future<void> shownotification(message) async {
//     AndroidNotificationChannel channel = AndroidNotificationChannel(
//       Random.secure().nextInt(100000).toString(),
//       'High Importance',
//       importance: Importance.max,
//       groupId: '1',
//     );
//     AndroidNotificationDetails androidnotificationdetail =
//         AndroidNotificationDetails(
//       channel.id.toString(),
//       channel.name.toString(),
//       icon: 'ic_launcher',
//       channelDescription: 'Your Channel Description',
//       importance: Importance.max,
//       priority: Priority.max,
//       ticker: 'ticker',
//     );
//     DarwinNotificationDetails darwinNotificationDetails =
//         DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );
//     NotificationDetails notificationdetails = NotificationDetails(
//       android: androidnotificationdetail,
//       iOS: darwinNotificationDetails,
//     );
//     Future.delayed(Duration.zero, () {
//       flutterlocalnotificationplugin.show(
//         0,
//         message.notification.title!.toString(),
//         message.notification.body!.toString(),
//         notificationdetails,
//         payload: message.data['data'],
//       );
//     });
//   }

//   Future sendnotification(String deviceToken, String title, String body) async {
//     var data = {
//       'to':
//           'fHldC-_pSWmY8bNMlnHp-_:APA91bEou4t8-M8_OrF13kagqVG9rbVc1oBfeCADJuc5amKFP1dHsa5k1L_TDEOp_Z4QitcvpDx3vyT4eWHhzDpMh3QuoZOBre8nmJmJHYiMPsK4w5-OllkdZEJ6HiG9EqffHSOzRhj6',
//       'priority': 'high',
//       'notification': {
//         'title': 'title',
//         'body': 'body',
//       }
//     };
//     await http.post(
//       Uri.parse('https://fcm.googleapis.com/fcm/send'),
//       body: jsonEncode(data),
//       headers: {
//         'Content-Type': 'application/json;charset=UTF-8',
//         'Authorization':
//             'Key=AAAAQpaz38E:APA91bFNslLR_Im-MJL8kOqCc9wK3rnajD9rURZaXZAaq-VA-YCj_JQHfW8eaRlUlCM8g_bDXgSiPlbWJW_SM9buSK08Ed4l_9vEc1e5DQsYtybSb_iCjSHhwO8U7n79708It_6QsqJX'
//       },
//     );
//   }
// }

import 'dart:convert';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
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
      AppSettings.openAppSettings(
        type: AppSettingsType.notification,
      );
    } else {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
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
    // addUserData(token);
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
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle tap event here
      print('Notification tapped: ${message.notification!.title}');
      // You can navigate to a specific screen or perform any action here
    });
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

  Future sendnotification(String deviceToken, String title, String body) async {
    var data = {
      'to': deviceToken,
      'priority': 'high',
      'notification': {
        'title': title,
        'body': body,
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
