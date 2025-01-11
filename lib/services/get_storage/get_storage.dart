import 'package:field_king/packages/config.dart';

class Preference {
  static GetStorage? box;

  static const fcmTokenKey = "fcmToken";
  static const isOtpVerifyKey = "isOtpVerify";
  static const phoneNumberKey = "phoneNumberKey";
  static const firstNameKey = "firstNameKey";
  static const lastNameKey = "lastNameKey";
  static const brandNameKey = "brandNameKey";
  static const userTypeKey = "userTypeKey";
  static const userIdKey = "userIdKey";
  static const sbPreference = "field_king_preference";

  init() async {
    await GetStorage.init(sbPreference);
    box = GetStorage(sbPreference);
  }

  static void writeToken(String? token) {
    box?.write(fcmTokenKey, token);
  }

  static readToken() {
    return box?.read(fcmTokenKey);
  }

  static void writeIsOtpVerify(bool? isOtpVerify) {
    box?.write(isOtpVerifyKey, isOtpVerify);
  }

  static readIsOtpVerify() {
    return box?.read(isOtpVerifyKey);
  }

  static void writePhoneNumber(String? phoneNumber) {
    box?.write(phoneNumberKey, phoneNumber);
  }

  static readPhoneNumber() {
    return box?.read(phoneNumberKey);
  }

  static void writeFirstName(String? firstName) {
    box?.write(firstNameKey, firstName);
  }

  static readFirstName() {
    return box?.read(firstNameKey);
  }

  static void writeLastName(String? lastName) {
    box?.write(lastNameKey, lastName);
  }

  static readLastName() {
    return box?.read(lastNameKey);
  }

  static void writeBrandName(String? brandName) {
    box?.write(brandNameKey, brandName);
  }

  static readBrandName() {
    return box?.read(brandNameKey);
  }

  static void writeUserType(String? userType) {
    box?.write(userTypeKey, userType);
  }

  static readUserType() {
    return box?.read(userTypeKey);
  }

  static void writeUserId(String? userId) {
    box?.write(userIdKey, userId);
  }

  static readUserId() {
    return box?.read(userIdKey);
  }
}
