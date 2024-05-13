import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

class GetStorageClass {
  static var box;
  // static var isSignup;
  static void initGetStorage() {
    box = GetStorage();
  }

  static readDetailsEntered() {
    return box.read('isDetailsEntered') ?? false;
  }

  static void writeDetailsEntered() {
    box.write('isDetailsEntered', true);
  }

  static void writeDeviceToken(String token) {
    box.write('deviceToken', token);
  }

  static String readDeviceToken() {
    return box.read('deviceToken');
  }

  static void writeUserPhoneNumber(String phoneNumber) {
    box.write('userPhoneNumber', phoneNumber);
  }

  static String readUserPhoneNumber() {
    return box.read('userPhoneNumber');
  }
}
