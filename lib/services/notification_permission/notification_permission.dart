import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationPermission {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static Future<void> requestNotificationPermission() async {
    if (await Permission.notification.isGranted) {
      print("Notification permission granted.");
    } else {
      PermissionStatus status = await Permission.notification.request();
      if (status.isGranted) {
        print("Notification permission granted.");
      } else if (status.isDenied) {
        print("Notification permission denied.");
      } else if (status.isPermanentlyDenied) {
        print("Notification permission permanently denied."
            "Ask user to enable it from settings.");
        openAppSettings();
      }
    }
  }
}

class ContactPermission {
  static Future<void> requestContactPermission() async {
    PermissionStatus status = await Permission.contacts.status;
    print('contact permission $status');

    if (await Permission.contacts.isGranted) {
      print("Notification permission granted.");
    } else {
      PermissionStatus status = await Permission.contacts.request();
      if (status.isGranted) {
        print("contacts permission granted.");
      } else if (status.isDenied) {
        print("contacts permission denied.");
      } else if (status.isPermanentlyDenied) {
        print("contacts permission permanently denied."
            "Ask user to enable it from settings.");
        openAppSettings();
      }
    }
  }
}
