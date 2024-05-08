import 'dart:async';

import 'package:field_king/services/function.dart';
import 'package:field_king/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SendOtpController extends GetxController {
  TextEditingController firstNameController = TextEditingController().obs.value;
  TextEditingController lastNameController = TextEditingController().obs.value;
  TextEditingController brandNameController = TextEditingController().obs.value;
  TextEditingController mobileNumberController =
      TextEditingController().obs.value;

  RxInt countDown = RxInt(0);
  RxBool OtpSend = RxBool(false);

  void isOtpSend() {
    OtpSend.value = !OtpSend.value;
  }

  void startCountDown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countDown.value > 0) {
        countDown.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void restartCountDown() {
    countDown.value = 6;
    startCountDown();
  }

  // @override
  // void onClose() {
  //   _timer.cancel();
  //   mobileNumberController.dispose();
  //   firstNameController.dispose();
  //   lastNameController.dispose();
  //   brandNameController.dispose();

  //   super.onClose();
  // }

  signIn(BuildContext context) {
    if (mobileNumberController.text.isEmpty) {
      showtoast(context, 'Enter Mobile Number', 3);
    } else if (mobileNumberController.text.length != 10) {
      showtoast(context, 'Enter 10 Digit Mobile Numner', 3);
    } else {
      isOtpSend();
      restartCountDown();
      showprocessindicator(context);

      sendOtp(context);
    }
  }

  signUp(BuildContext context) {
    if (firstNameController.text.isEmpty) {
      showtoast(context, 'Enter First Name', 3);
    } else if (lastNameController.text.isEmpty) {
      showtoast(context, 'Enter Last Name', 3);
    } else if (brandNameController.text.isEmpty) {
      showtoast(context, 'Enter Brand Name', 3);
    } else if (mobileNumberController.text.isEmpty) {
      showtoast(context, 'Enter Mobile Number', 3);
    } else if (mobileNumberController.text.length != 10) {
      showtoast(context, 'Enter Valid Mobile Number', 3);
    } else {
      isOtpSend();
      restartCountDown();
      showprocessindicator(context);
      sendOtp(context);
    }
  }

  reSendOtp(BuildContext context) {
    if (mobileNumberController.value.text.length != 10) {
      showtoast(context, 'Please Enter Valid Mobile Number', 3);
    } else if (countDown.value == 0 &&
        mobileNumberController.value.text.length == 10) {
      restartCountDown();
    } else {}
  }
}
