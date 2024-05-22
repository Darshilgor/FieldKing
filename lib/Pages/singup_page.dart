import 'dart:ffi';

import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:field_king/controller/send_otp_controller.dart';
import 'package:field_king/services/app_color/app_colors.dart';
import 'package:field_king/services/get_storage/get_storage.dart';
import 'package:field_king/services/notification/notification_services.dart';
import 'package:field_king/services/text_label/text_label.dart';
import 'package:field_king/widgets/widgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with WidgetsBindingObserver {
  SendOtpController signupController = Get.put(SendOtpController());
  FocusNode _focusNode = FocusNode();
  NotificationServices notificationservices = NotificationServices();
  bool tapped = false;
  bool _navigatedToSettings = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    callFunction();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if(state == AppLifecycleState.resumed){
      callFunction();
    }
  }
  // Future<void> _addContactsToFirebase() async {
  //   if (tapped) {
  //     print('inside add contact function');
  //     List<Contact> contactList = await ContactsService.getContacts();
  //     await FirebaseFirestore.instance
  //         .collection('Users')
  //         .doc(GetStorageClass.readUserPhoneNumber())
  //         .update({
  //       'contact': contactList,
  //     });
  //   }
  // }

  // @override
  // Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
  //   print('did call..................................');
  //   // TODO: implement didChangeAppLifecycleState
  //   super.didChangeAppLifecycleState(state);
  //   NotificationServices services = NotificationServices();
  //   if (!await Permission.contacts.isGranted) {
  //     await AppSettings.openAppSettings(asAnotherTask: false);
  //   } else {
  //     print('granted....................................');
  //   }
  //   // else {
  //   //   if (!await Permission.notification.isGranted) {
  //   //     await AppSettings.openAppSettings().whenComplete(() {
  //   //       return;
  //   //     });
  //   //   } else {
  //   //     print('all permissions are granted.........');
  //   //   }
  //   // }
  // }
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed && _navigatedToSettings) {
  //     _navigatedToSettings = false;
  //     requestContactPermission();
  //   }
  // }

  // Future<void> requestContactPermission() async {
  //   PermissionStatus status = await Permission.contacts.status;
  //   if (status.isGranted) {
  //     print('Permission granted.');
  //     // You can add the contacts to Firebase or perform other actions here if needed.
  //   } else if (status.isDenied || status.isPermanentlyDenied) {
  //     await Permission.contacts.request();
  //     if (await Permission.contacts.isGranted) {
  //       print('Permission granted after request.');
  //       // You can add the contacts to Firebase or perform other actions here if needed.
  //     } else {
  //      await _navigateToSettings();
  //     }
  //   }
  // }

  // Future<void> _navigateToSettings() async {
  //   _navigatedToSettings = true;
  //   showtoast(context, 'Allow contact permission in settings', 3);
  //   await Future.delayed(Duration(seconds: 3))
  //       .whenComplete(() => AppSettings.openAppSettings());
  // }

  Future callFunction() async {
    if (!await Permission.contacts.isGranted) {
      print('inside function.......................................${Permission.contacts.status}');
      NotificationServices services = NotificationServices();
      await services.getContactPermission(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {});
    // print('inside build................................');
    // callFunction();
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        title: Text(
          TextLabel.enterDetails,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            formfield(
              context,
              TextLabel.enterFirstName,
              TextLabel.hintFirstName,
              signupController.firstNameController,
              20,
              '',
              TextInputType.name,
              onchange,
              onfieldsubmitted,
              FilteringTextInputFormatter.singleLineFormatter,
              LengthLimitingTextInputFormatter(20),
              readOnly: false,
            ),
            formfield(
              context,
              TextLabel.enterLastName,
              TextLabel.hintLastName,
              signupController.lastNameController,
              20,
              '',
              TextInputType.name,
              onchange,
              onfieldsubmitted,
              FilteringTextInputFormatter.singleLineFormatter,
              LengthLimitingTextInputFormatter(20),
              readOnly: false,
            ),
            formfield(
              context,
              TextLabel.enterBrandName,
              TextLabel.hintBrandName,
              signupController.brandNameController,
              20,
              '',
              TextInputType.name,
              onchange,
              onfieldsubmitted,
              FilteringTextInputFormatter.singleLineFormatter,
              LengthLimitingTextInputFormatter(20),
              readOnly: false,
            ),
            formfield(
                context,
                TextLabel.enterMobileNumber,
                TextLabel.hintMobileNumber,
                TextEditingController(
                    text: GetStorageClass.readUserPhoneNumber()),
                10,
                '',
                TextInputType.number,
                onchange,
                onfieldsubmitted,
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
                focusNode: _focusNode,
                readOnly: true),
            GestureDetector(
              onTap: () {
                showprocessindicator(context);
                // getPermissionAndAddContact();
                signupController.signUp(context);
              },
              child: buttonwidget(
                context,
                TextLabel.submit,
                AppColor.bgcolor1,
                AppColor.bgcolor2,
                AppColor.whitecolor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onchange(String value) {}

  void onfieldsubmitted(String? value) {}

  // Future<void> getPermissionAndAddContact() async {
  //   await notificationservices.getContactPermission(context);
  //   if (await Permission.contacts.isGranted) {
  //     notificationservices.requestnotificationpermission();
  //     _addContactsToFirebase();
  //     print('granted');
  //   } else {
  //     showtoast(context, 'Allow contact permission', 3);
  //     await Future.delayed(Duration(seconds: 3))
  //         .whenComplete(() => AppSettings.openAppSettings());
  //   }
  // }
}
