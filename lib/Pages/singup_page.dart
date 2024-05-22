import 'package:app_settings/app_settings.dart';
import 'package:field_king/controller/send_otp_controller.dart';
import 'package:field_king/services/app_color/app_colors.dart';
import 'package:field_king/services/get_storage/get_storage.dart';
import 'package:field_king/services/notification/notification_services.dart';
import 'package:field_king/services/text_label/text_label.dart';
import 'package:field_king/widgets/widgets.dart';
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

    if (state == AppLifecycleState.resumed) {
      callFunction();
    }
  }

  Future callFunction() async {
    if (await Permission.contacts.isDenied) {
      NotificationServices services = NotificationServices();
      await services.getContactPermission(context);
    } else if (await Permission.contacts.isPermanentlyDenied) {
      showtoast(context, 'Allow contact permission', 3);
      await Future.delayed(Duration(seconds: 3))
          .whenComplete(() => AppSettings.openAppSettings());
    } else if (await Permission.notification.isDenied) {
      NotificationServices services = NotificationServices();
      services.requestnotificationpermission();
    } else if (await Permission.notification.isPermanentlyDenied) {
      showtoast(context, 'Allow notification permission', 3);
      await Future.delayed(Duration(seconds: 3))
          .whenComplete(() => AppSettings.openAppSettings());
    }
  }

  @override
  Widget build(BuildContext context) {
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
}
