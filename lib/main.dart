import 'dart:async';

import 'package:field_king/Pages/home_page.dart';
import 'package:field_king/Pages/home_page_view.dart';
import 'package:field_king/Pages/login_page.dart';
import 'package:field_king/Pages/singup_page.dart';
import 'package:field_king/Pages/splash_screen.dart';
import 'package:field_king/Pages/three_task.dart';
import 'package:field_king/firebase_options.dart';
import 'package:field_king/services/get_storage/get_storage.dart';
import 'package:field_king/services/notification/notification_services.dart';
import 'package:field_king/services/text_label/text_label.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

@pragma('vm:entry-point')
Future<void> backgroundNotificationHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  await Firebase.initializeApp();

  await setupFlutterNotifications();
  showFlutterNotification(message);
  // NotificationServices notificationservices = NotificationServices();
  // notificationservices.shownotification(message);
}

Future main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseAppCheck.instance.activate();
  FirebaseMessaging.onBackgroundMessage(backgroundNotificationHandler);
  // handleNotification();
  await GetStorage.init();

  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // final notificationAppLaunchDetails =
  //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  // if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
  //   final message = notificationAppLaunchDetails!.notificationResponse;
  // }

  runApp(const MyApp());
}

// Future handleNotification() async {
//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     if (message.notification!.body == 'Welcome to Field King') {
//       print('Welcome to Field King Brand');
//     }
//   });
// }

late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

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
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   if (message.notification!.body == 'Welcome to Field King') {
    //     print('Welcome to Field King Brand');
    //   }
    // });
    // NotificationServices services = NotificationServices();
    // services.firebaseinit(context);
  }

  // late FirebaseMessaging _firebaseMessaging;
  // late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  // @override
  // void initState() {
  //   super.initState();
  //   GetStorageClass.initGetStorage();
  //   _firebaseMessaging = FirebaseMessaging.instance;
  //   _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //   // Initialize Firebase Messaging
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print('onMessage: $message');
  //     _showNotification(message);
  //   });

  //   FirebaseMessaging.onBackgroundMessage(_backgroundNotificationHandler);

  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     print('onMessageOpenedApp: $message');
  //   });

  //   // Initialize Local Notifications
  //   var initializationSettingsAndroid =
  //       AndroidInitializationSettings('@mipmap/ic_launcher');
  //   var initializationSettingsIOS = DarwinInitializationSettings();
  //   var initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid,
  //     iOS: initializationSettingsIOS,
  //   );
  //   _flutterLocalNotificationsPlugin.initialize(
  //     initializationSettings,
  //     // onSelectNotification: (String? payload) async {
  //     //   if (payload != null) {
  //     //     print('Notification payload: $payload');
  //     //   }
  //     // },
  //   );

  //   // Request notification permissions
  //   _requestNotificationPermissions();
  // }

  // Future<void> _requestNotificationPermissions() async {
  //   NotificationSettings settings = await _firebaseMessaging.requestPermission(
  //     alert: true,
  //     announcement: true,
  //     badge: true,
  //     sound: true,
  //   );
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print("User granted permission");
  //   } else if (settings.authorizationStatus ==
  //       AuthorizationStatus.provisional) {
  //     print("User granted provisional permission");
  //   } else {
  //     print("User denied permission");
  //   }
  // }

  // Future<void> _backgroundNotificationHandler(RemoteMessage message) async {
  //   print("Handling a background message: ${message.messageId}");
  //   _showNotification(message);
  // }

  // Future<void> _showNotification(RemoteMessage message) async {
  //   AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     'your channel id',
  //     'your channel name',
  //     // 'your channel description',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );
  //   NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await _flutterLocalNotificationsPlugin.show(
  //     0,
  //     message.notification?.title,
  //     message.notification?.body,
  //     platformChannelSpecifics,
  //     payload: message.data['data'],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: TextLabel.branchName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: (FirebaseAuth.instance.currentUser == null)
          ? LoginPage()
          : (GetStorageClass.readDetailsEntered() == true)
              ? HomePageView()
              : SignUpPage(),
      // home: ThreeTask(),
    );
  }
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

// Future<void> setupFlutterNotifications() async {
//   if (isFlutterLocalNotificationsInitialized) {
//     return;
//   }
//   channel = const AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.high,
//   );
//   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   isFlutterLocalNotificationsInitialized = true;
// }

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'ic_launcher',
        ),
      ),
    );
  }
}



// void showFlutterNotification(RemoteMessage message) {
//   RemoteNotification? notification = message.notification;
//   AndroidNotification? android = message.notification?.android;
//   if (notification != null && android != null && !kIsWeb) {
//     flutterLocalNotificationsPlugin.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           channelDescription: channel.description,
//           icon: 'ic_launcher',
//         ),
//       ),
//     );
//   }
// }
