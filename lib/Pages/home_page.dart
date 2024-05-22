import 'package:field_king/services/get_storage/get_storage.dart';
import 'package:field_king/services/notification/notification_services.dart';
import 'package:field_king/services/text_label/text_label.dart';
import 'package:field_king/services/text_style/text_style.dart';
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

    notificationservices.forgroundMessage();
    notificationservices.firebaseinit(context);
    notificationservices.setupInteractMessage(context);
    notificationservices.sendnotification(GetStorageClass.readDeviceToken(),
        TextLabel.branchName, TextLabel.welcomeToFieldKing);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TextLabel.branchName,
          style: TextStyleClass.headingtext,
        ),
      ),
      body: InkWell(
        onTap: () {
          FirebaseAuth.instance.signOut();
        },
        child: Text(
          TextLabel.logIn,
        ),
      ),
    );
  }
}
