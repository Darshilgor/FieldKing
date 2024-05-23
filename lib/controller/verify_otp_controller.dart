import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:field_king/Pages/home_page.dart';
import 'package:field_king/Pages/home_page_view.dart';
import 'package:field_king/Pages/singup_page.dart';
import 'package:field_king/services/function.dart';
import 'package:field_king/services/get_storage/get_storage.dart';
import 'package:field_king/services/notification/notification_services.dart';
import 'package:field_king/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class VerifyOtpController extends GetxController {
  RxString otpId = RxString('');
  TextEditingController controller1 = TextEditingController().obs.value;
  TextEditingController controller2 = TextEditingController().obs.value;
  TextEditingController controller3 = TextEditingController().obs.value;
  TextEditingController controller4 = TextEditingController().obs.value;
  TextEditingController controller5 = TextEditingController().obs.value;
  TextEditingController controller6 = TextEditingController().obs.value;

  void fillOtpFields(String otp) {
    if (otp.length == 6) {
      print('inside opt length');
      controller1.text = otp[0];
      controller2.text = otp[1];
      controller3.text = otp[2];
      controller4.text = otp[3];
      controller5.text = otp[4];
      controller6.text = otp[5];
    }
  }

  verifyOtpMethod(BuildContext context) async {
    if (controller1.text.isEmpty ||
        controller2.text.isEmpty ||
        controller3.text.isEmpty ||
        controller4.text.isEmpty ||
        controller5.text.isEmpty ||
        controller6.text.isEmpty) {
      showtoast(context, 'Enter Otp', 3);
    } else if (controller1.text.isNotEmpty &&
        controller2.text.isNotEmpty &&
        controller3.text.isNotEmpty &&
        controller4.text.isNotEmpty &&
        controller5.text.isNotEmpty &&
        controller6.text.isNotEmpty) {
      User? user = await verifyOtp(context,
          '${controller1.text.toString()}${controller2.text.toString()}${controller3.text.toString()}${controller4.text.toString()}${controller5.text.toString()}${controller6.text.toString()}');

      if (user != null) {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(GetStorageClass.readUserPhoneNumber())
            .get()
            .then(
          (DocumentSnapshot snapshot) async {
            hideprocessindicator(context);

            if (snapshot.exists) {
              Get.offAll(HomePageView());
            } else {
              Get.off(SignUpPage());
            }
          },
        );
      }
    }
  }
}
