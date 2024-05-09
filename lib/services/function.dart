import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/Pages/otp_page.dart';
import 'package:field_king/controller/send_otp_controller.dart';
import 'package:field_king/controller/verify_otp_controller.dart';
import 'package:field_king/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future sendOtp(BuildContext context) async {
  SendOtpController sendOtpController = Get.put(SendOtpController());
  VerifyOtpController verifyOtpController = Get.put(VerifyOtpController());
  try {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${sendOtpController.mobileNumberController.text}',
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (e) {
        hideprocessindicator(context);
        sendOtpverificationFailed(context, e.code);
      },
      codeSent: (verificationId, forceResendingToken) {
        print(verificationId);
        verifyOtpController.otpId.value = verificationId.toString();
        print(verifyOtpController.otpId.value);
        if (verifyOtpController.otpId.isNotEmpty) {
          hideprocessindicator(context);
          Get.to(const OtpPage());
        }
      },
      codeAutoRetrievalTimeout: (verificationId) {
        verifyOtpController.otpId.value = verificationId.toString();
      },
    );
  } catch (e) {
    hideprocessindicator(context);
    showtoast(context, e.toString(), 5);
  }
}

Future verifyOtp(BuildContext context, String otp) async {
  VerifyOtpController verifyOtpController = Get.put(VerifyOtpController());

  UserCredential? user;

  try {
    PhoneAuthCredential userCredential = PhoneAuthProvider.credential(
        verificationId: verifyOtpController.otpId.value, smsCode: otp);

    user = await FirebaseAuth.instance.signInWithCredential(userCredential);

    if (user.user != null) {
      updateHive();
      addUserData();

      if (user.user != null) {
        // hive.up
        // addUserData();

        return user.user;
      }
    }

    return user.user;
  } catch (e) {
    hideprocessindicator(context);

    verifyOtpVerificationFailed(context, e);
  }
  return;
}

void sendOtpverificationFailed(context, String code) {
  switch (code) {
    case 'invalid-phone-number':
      showtoast(context,
          'Invalid phone number. Please enter a valid phone number.', 5);
      break;
    case 'quota-exceeded':
      showtoast(context, 'Quota exceeded. Please try again later.', 5);
      break;
    case 'missing-client-identifier':
      showtoast(
          context,
          'Missing client identifier. Please check your Firebase project configuration.',
          5);
      break;
    case 'app-not-authorized':
      showtoast(
          context, 'App not authorized to use Firebase Authentication.', 5);
      break;
    case 'user-disabled':
      showtoast(context, 'User account disabled. Please contact support.', 5);
      break;
    case 'network-request-failed':
      showtoast(context,
          'Network request failed. Please check your internet connection.', 5);
      break;
    default:
      print('Unhandled error: ${code}');
      break;
  }
}

// void verifyOtpVerificationFailed(BuildContext context, e) {
//   if (e is FirebaseAuthException) {
//     switch (e.code) {
//       case 'invalid-verification-code':
//         showtoast(
//             context, 'Invalid OTP. Please enter a valid verification code.', 5);
//         break;
//       case 'too-many-requests':
//         showtoast(context,
//             'Too many verification requests. Please try again later.', 5);
//         break;
//       case 'session-expired':
//         showtoast(
//             context,
//             'Verification session expired. Please restart the verification process.',
//             5);
//         break;
//       case 'quota-exceeded':
//         showtoast(context, 'Quota exceeded. Please try again later.', 5);
//         break;
//       case 'internal-error':
//         showtoast(
//             context, 'Internal error occurred. Please try again later.', 5);
//         break;
//       case 'invalid-phone-number':
//         showtoast(context,
//             'Invalid phone number. Please enter a valid phone number.', 5);
//         break;
//       case 'missing-client-identifier':
//         showtoast(
//             context,
//             'Missing client identifier. Please check your Firebase project configuration.',
//             5);
//         break;
//       case 'app-not-authorized':
//         showtoast(
//             context, 'App not authorized to use Firebase Authentication.', 5);
//         break;
//       case 'user-disabled':
//         showtoast(context, 'User account disabled. Please contact support.', 5);
//         break;
//       case 'network-request-failed':
//         showtoast(
//             context,
//             'Network request failed. Please check your internet connection.',
//             5);
//         break;
//       default:
//         print('Unhandled error: ${e.code}');
//         break;
//     }
//   } else {
//     showtoast(context, e.toString(), 3);
//   }
// }

// Future updateHive() async {
//   var directory = await getApplicationDocumentsDirectory();
//   Hive.init(directory.path);
//   var box = await Hive.openBox('Field King');

//   try {
//     box.put('isSignup', true);
//     var value = box.get('isSignup');
//     print(value);
//   } catch (e) {
//     print('Error updating Hive box: $e');
//   } finally {
//     await box.close();
//   }
// }

void verifyOtpVerificationFailed(BuildContext context, e) {
  if (e is FirebaseAuthException) {
    switch (e.code) {
      case 'invalid-verification-code':
        showtoast(
            context, 'Invalid OTP. Please enter a valid verification code.', 5);
        break;
      case 'too-many-requests':
        showtoast(context,
            'Too many verification requests. Please try again later.', 5);
        break;
      case 'session-expired':
        showtoast(
            context,
            'Verification session expired. Please restart the verification process.',
            5);
        break;
      case 'quota-exceeded':
        showtoast(context, 'Quota exceeded. Please try again later.', 5);
        break;
      case 'internal-error':
        showtoast(
            context, 'Internal error occurred. Please try again later.', 5);
        break;
      case 'invalid-phone-number':
        showtoast(context,
            'Invalid phone number. Please enter a valid phone number.', 5);
        break;
      case 'missing-client-identifier':
        showtoast(
            context,
            'Missing client identifier. Please check your Firebase project configuration.',
            5);
        break;
      case 'app-not-authorized':
        showtoast(
            context, 'App not authorized to use Firebase Authentication.', 5);
        break;
      case 'user-disabled':
        showtoast(context, 'User account disabled. Please contact support.', 5);
        break;
      case 'network-request-failed':
        showtoast(
            context,
            'Network request failed. Please check your internet connection.',
            5);
        break;
      default:
        print('Unhandled error: ${e.code}');
        break;
    }
  } else {
    showtoast(context, e.toString(), 3);
  }
}

Future updateHive() async {
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  var box = await Hive.openBox('Field King');

  try {
    box.put('isSignup', true);
    var value = box.get('isSignup');
    print(value);
  } catch (e) {
    print('Error updating Hive box: $e');
  } finally {
    await box.close();
  }
}

Future addUserData() async {
  SendOtpController sendOtpController = Get.put(SendOtpController());
  await FirebaseFirestore.instance
      .collection('Users')
      .doc('+91${sendOtpController.mobileNumberController.text}')
      .set({
    'First Name': sendOtpController.firstNameController.text,
    'Last Name': sendOtpController.lastNameController.text,
    'Brand Name': sendOtpController.brandNameController.text,
    'Phone Number': '+91${sendOtpController.mobileNumberController.text}',
  });
}
