import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/Pages/otp_page.dart';
import 'package:field_king/controller/send_otp_controller.dart';
import 'package:field_king/controller/verify_otp_controller.dart';
import 'package:field_king/services/get_storage/get_storage.dart';
import 'package:field_king/services/notification/notification_services.dart';
import 'package:field_king/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

Future sendOtp(BuildContext context) async {
  SendOtpController sendOtpController = Get.put(SendOtpController());
  VerifyOtpController verifyOtpController = Get.put(VerifyOtpController());
  try {
    await SmsAutoFill().listenForCode;
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${sendOtpController.mobileNumberController.text}',
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          // print('inside verification completed');
          // String smsCode = phoneAuthCredential.smsCode!;
          // verifyOtpController.fillOtpFields(smsCode);
          // print(
          //     'phoneAuthCredential.smsCode.toString()${phoneAuthCredential.smsCode.toString()}');

          // Read OTP from phoneAuthCredential
          String? smsCode = phoneAuthCredential.smsCode;

          if (smsCode != null) {
            // Fill OTP fields
            verifyOtpController.fillOtpFields(smsCode);
            print('OTP from SMS: $smsCode');

            // Proceed with verification
            await FirebaseAuth.instance
                .signInWithCredential(phoneAuthCredential);

            // Optionally, navigate to the OTP page
            Get.to(const OtpPage());
          }
        },
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
          if (Get.currentRoute == '/OtpPage') {
            print('inside the opt page');
            return;
          } else {
            hideprocessindicator(context);
            print('after timeout');
            verifyOtpController.otpId.value = verificationId.toString();
            return;
          }
        },
        timeout: Duration(seconds: 20));
  } catch (e) {
    hideprocessindicator(context);
    showtoast(context, e.toString(), 5);
  }
}

Future verifyOtp(BuildContext context, String otp) async {
  VerifyOtpController verifyOtpController = Get.put(VerifyOtpController());
  SendOtpController sendOtpController = Get.put(SendOtpController());
  UserCredential? user;

  try {
    PhoneAuthCredential userCredential = PhoneAuthProvider.credential(
        verificationId: verifyOtpController.otpId.value, smsCode: otp);

    user = await FirebaseAuth.instance.signInWithCredential(userCredential);

    if (user.user != null) {
      // GetStorageClass.writeSignup();

      NotificationServices services = NotificationServices();
      GetStorageClass.writeUserPhoneNumber(
          '+91${sendOtpController.mobileNumberController.text}');
      services.ontokenrefresh();
      services.getdevicetoken().then((value) {
        print(value);
        GetStorageClass.writeDeviceToken(value);
        print('token was writen');
      });
      return user.user;
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
    case 'too-many-requests':
      showtoast(context,
          'To many request try after some times,Or call on +919409529203', 10);
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

Future addUserData() async {
  SendOtpController sendOtpController = Get.put(SendOtpController());
  // NotificationServices services = NotificationServices();
  // print('services.token.toString()${services.token.toString()}');
  await FirebaseFirestore.instance
      .collection('Users')
      .doc('+91${sendOtpController.mobileNumberController.text}')
      .set({
    'First Name': sendOtpController.firstNameController.text,
    'Last Name': sendOtpController.lastNameController.text,
    'Brand Name': sendOtpController.brandNameController.text,
    'Phone Number': GetStorageClass.readUserPhoneNumber(),
    'token': GetStorageClass.readDeviceToken(),
  });
}
