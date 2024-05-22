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

// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';

// import 'package:app_settings/app_settings.dart';
// import 'package:field_king/Pages/login_page.dart';
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
//         if (Platform.isIOS) {
//           forgroundMessage();
//         }

//         if (Platform.isAndroid) {
//           initlocalnotifications(context, message);
//           shownotification(message);
//         }
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

//     await flutterlocalnotificationplugin.initialize(
//       initiallizesetting,
//       onDidReceiveNotificationResponse: (details) {
//         if (details.input != null) {
//           print('details $details');
//         }
//       },
//       //  onDidReceiveBackgroundNotificationResponse: (payload) {
//       //   print('payload $payload');
//       //   // handleNotificationTap(context, payload as String?);
//       // }
//     );
//   }

//   Future<void> shownotification(message) async {
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;
//     AndroidNotificationChannel channel = AndroidNotificationChannel(
//       Random.secure().nextInt(100000).toString(),
//       'High Importance',
//       importance: Importance.max,
//       groupId: '1',
//     );
//     if (notification != null && android != null && !kIsWeb) {
//       AndroidNotificationDetails androidnotificationdetail =
//           AndroidNotificationDetails(
//         channel.id.toString(),
//         channel.name.toString(),
//         icon: 'ic_launcher',
//         channelDescription: 'Your Channel Description',
//         importance: Importance.max,
//         priority: Priority.max,
//         ticker: 'ticker',
//       );
//       DarwinNotificationDetails darwinNotificationDetails =
//           DarwinNotificationDetails(
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true,
//       );
//       NotificationDetails notificationdetails = NotificationDetails(
//         android: androidnotificationdetail,
//         iOS: darwinNotificationDetails,
//       );
//       Future.delayed(Duration.zero, () {
//         flutterlocalnotificationplugin.show(
//           0,
//           message.notification.title!.toString(),
//           message.notification.body!.toString(),
//           notificationdetails,
//           payload: message.data.toString(),
//         );
//       });
//     }
//   }

//   Future sendnotification(String deviceToken, String title, String body) async {
//     var data = {
//       'to':
//           'ccb66IrrTYqqTcTrF1DXws:APA91bHn8jO2N98ksPIa2PCxuwfpYs02wKXLyZhcQrV3yLD7UQLAD82Ds3m6m8pcCI96ULAIkGJTmCKQm-V9FtUwnSOxD0NhHL4ntJ-2RtgnWYmzL4-ngALkYFvlZd8zYuJcVGmB2Bze',
//       'priority': 'high',
//       'notification': {
//         'title': title,
//         'body': body,
//       },
//       'android': {
//         'notification': {
//           'notification_count': 23,
//         },
//       },
//       'data': {
//         'via': 'FlutterFire Cloud Messaging!!!',
//         'type': 'Gor',
//         'id': 'Darshil'
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

//   Future forgroundMessage() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }

//   Future<void> setupInteractMessage(BuildContext context) async {
//     RemoteMessage? initialMessage =
//         await FirebaseMessaging.instance.getInitialMessage();
//     print('message');
//     if (initialMessage != null) {
//       print('message');

//       handleNotificationTap(context, jsonEncode(initialMessage.data));
//     }

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('message');

//       print('message $message');
//       handleNotificationTap(context, jsonEncode(message.data));
//     });
//   }

//   void handleNotificationTap(BuildContext context, String? payload) {
//     if (payload != null) {
//       var data = jsonDecode(payload);
//       if (data['type'] == 'Gor') {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => LoginPage()),
//         );
//       }
//     }
//   }

//   // Future<void> setupInteractMessage(BuildContext context) async {
//   //   // when app is terminated
//   //   RemoteMessage? initialMessage =
//   //       await FirebaseMessaging.instance.getInitialMessage();

//   //   if (initialMessage != null) {
//   //     handleMessage(context, initialMessage);
//   //   }

//   //   //when app ins background
//   //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//   //     handleMessage(context, message);
//   //   });
//   // }

//   // void handleMessage(BuildContext context, RemoteMessage message) {

//   //   if (message.data['type'] == 'Gor') {
//   //     Navigator.push(
//   //         context, MaterialPageRoute(builder: (context) => SignUpPage()));
//   //   }
//   // }
// }

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:field_king/Pages/login_page.dart';
import 'package:field_king/widgets/widgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterlocalnotificationplugin =
      FlutterLocalNotificationsPlugin();

  requestnotificationpermission() async {
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

  Future getContactPermission(BuildContext context) async {
    // await Permission.contacts.request();
    // PermissionStatus status = await Permission.contacts.status;
    // print(status);
    // if (status.isGranted) {
    //   if (await Permission.notification.isGranted) {
    //     return;
    //   }
    //   //  else {
    //   // //   NotificationServices services = NotificationServices();
    //   // //  await services.requestnotificationpermission();
    //   //   return;
    //   // }
    // }
    // return;

    var galleryAccessStatus = await Permission.contacts.status;
    print('galleryAccessStatus $galleryAccessStatus');
    if (galleryAccessStatus != PermissionStatus.granted) {
      //here
      var status;
      if (await Permission.contacts.status.isPermanentlyDenied) {
        status = await Permission.contacts.request().whenComplete(
            () => print('inside request........................'));
      }
      status = await Permission.contacts
          .request()
          .whenComplete(() => print('inside request........................'));
      print('status $status');
      if (status != PermissionStatus.granted) {
        //here
        await openAppSettings();
      }
    }
    return;
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
        if (Platform.isIOS) {
          forgroundMessage();
        }

        if (Platform.isAndroid) {
          initlocalnotifications(context, message);
          shownotification(message);
        }
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

    await flutterlocalnotificationplugin.initialize(
      initiallizesetting,
      onDidReceiveNotificationResponse: (details) {
        if (details.input != null) {
          print('details $details');
        }
      },
      //  onDidReceiveBackgroundNotificationResponse: (payload) {
      //   print('payload $payload');
      //   // handleNotificationTap(context, payload as String?);
      // }
    );
  }

  Future<void> shownotification(message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      'High Importance',
      importance: Importance.max,
      groupId: '1',
    );
    if (notification != null && android != null && !kIsWeb) {
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
          payload: message.data.toString(),
        );
      });
    }
  }

  Future sendnotification(String deviceToken, String title, String body) async {
    var data = {
      'to': deviceToken,
      'priority': 'high',
      'notification': {
        'title': title,
        'body': body,
      },
      'android': {
        'notification': {
          'notification_count': 23,
        },
      },
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
        'type': 'Gor',
        'id': 'Darshil'
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

  Future forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    print('message');
    if (initialMessage != null) {
      print('message');

      handleNotificationTap(context, jsonEncode(initialMessage.data));
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('message');

      print('message $message');
      handleNotificationTap(context, jsonEncode(message.data));
    });
  }

  void handleNotificationTap(BuildContext context, String? payload) {
    if (payload != null) {
      var data = jsonDecode(payload);
      if (data['type'] == 'Gor') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    }
  }

  // Future<void> setupInteractMessage(BuildContext context) async {
  //   // when app is terminated
  //   RemoteMessage? initialMessage =
  //       await FirebaseMessaging.instance.getInitialMessage();

  //   if (initialMessage != null) {
  //     handleMessage(context, initialMessage);
  //   }

  //   //when app ins background
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     handleMessage(context, message);
  //   });
  // }

  // void handleMessage(BuildContext context, RemoteMessage message) {

  //   if (message.data['type'] == 'Gor') {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => SignUpPage()));
  //   }
  // }
}
