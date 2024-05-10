import 'package:get_storage/get_storage.dart';

class GetStorageClass {
  static var box;
  static var isSignup;
  static void initGetStorage() {
    box = GetStorage();
  }

  static readSignup() {
    return box.read('isSignup') ?? false;
  }

  static void writeSignup() {
    box.write('isSignup', true);
  }

  static void writeDeviceToken(String token) {
    box.write('deviceToken', token);
  }

  static void readDeviceToken() {
    return box.read('deviceToken');
  }

  static void writeUserPhoneNumber(String phoneNumber) {
    box.write('userPhoneNumber', phoneNumber);
  }
}
