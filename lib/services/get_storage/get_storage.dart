import 'package:field_king/packages/config.dart';

class Preference {
  static GetStorage? box;

  static const fcmTokenKey = "fcmToken";
  static const isOtpVerifyKey = "isOtpVerify";
  static const phoneNumberKey = "phoneNumberKey";
  static const addresssKey = "addressKey";
  static const firstNameKey = "firstNameKey";
  static const lastNameKey = "lastNameKey";
  static const brandNameKey = "brandNameKey";
  static const userTypeKey = "userTypeKey";
  static const userIdKey = "userIdKey";
  static const sbPreference = "field_king_preference";
  static const isLoginKey = "isLogin";
  static const isShowWithOutGstKey = 'isShowWithOutGst';
  static const profileImageKey = 'profileImageKey';
  static const totalOrderMeterKey = 'totalOrderMeterKey';
  static const totalOrderAmountKey = 'totalOrderAmountKey';
  static const deviceIdKey = 'deviceIdKey';
  static const orderFirstNameKey = 'orderFirstNameKey';
  static const orderLastNameKey = 'orderLastNameKey';
  static const orderBrandNameKey = 'orderBrandNameKey';
  static const orderPhoneNoKey = 'orderPhoneNoKey';
  static const orderLocationKey = 'orderLocationKey';

  init() async {
    await GetStorage.init(sbPreference);
    box = GetStorage(sbPreference);
  }

  static String? get fcmToken => box?.read<String>(fcmTokenKey);
  static set fcmToken(String? token) => box?.write(fcmTokenKey, token);

  // OTP Verification Status
  static bool? get isOtpVerified => box?.read<bool>(isOtpVerifyKey);
  static set isOtpVerified(bool? value) => box?.write(isOtpVerifyKey, value);

  // Is Login.
  static bool? get isLogin => box?.read<bool>(isLoginKey);
  static set isLogin(bool? value) => box?.write(isLoginKey, value);

  // // Is isShowWithOutGst.
  // static bool? get isShowWithOutGst => box?.read<bool>(isShowWithOutGstKey);
  // static set isShowWithOutGst(bool? value) => box?.write(isShowWithOutGstKey, value);

  // Phone Number.
  static String? get phoneNumber => box?.read<String>(phoneNumberKey);
  static set phoneNumber(String? number) => box?.write(phoneNumberKey, number);

  // Address.
  static String? get address => box?.read<String>(addresssKey);
  static set address(String? number) => box?.write(addresssKey, number);

  // profile Photo.
  static String? get profileImage => box?.read<String>(profileImageKey);
  static set profileImage(String? profileImage) =>
      box?.write(profileImageKey, profileImage);

  // total order meter.
  static String? get totalOrderMeter => box?.read<String>(totalOrderMeterKey);
  static set totalOrderMeter(String? totalOrderMeter) =>
      box?.write(totalOrderMeterKey, totalOrderMeter);

  // total order amout.
  static String? get totalOrderAmount => box?.read<String>(totalOrderAmountKey);
  static set totalOrderAmount(String? totalOrderAmount) =>
      box?.write(totalOrderAmountKey, totalOrderAmount);

  // device id.
  static String? get deviceId => box?.read<String>(deviceIdKey);
  static set deviceId(String? deviceId) => box?.write(deviceIdKey, deviceId);

  // First Name
  static String? get firstName => box?.read<String>(firstNameKey);
  static set firstName(String? name) => box?.write(firstNameKey, name);

  // Last Name
  static String? get lastName => box?.read<String>(lastNameKey);
  static set lastName(String? name) => box?.write(lastNameKey, name);

  // Brand Name
  static String? get brandName => box?.read<String>(brandNameKey);
  static set brandName(String? name) => box?.write(brandNameKey, name);

  // User Type
  static String? get userType => box?.read<String>(userTypeKey);
  static set userType(String? type) => box?.write(userTypeKey, type);

  // User ID
  static String? get userId => box?.read<String>(userIdKey);
  static set userId(String? id) => box?.write(userIdKey, id);

  // order first name
  static String? get orderFirstName => box?.read<String>(orderFirstNameKey);
  static set orderFirstName(String? name) =>
      box?.write(orderFirstNameKey, name);

  // order last name
  static String? get orderLastName => box?.read<String>(orderLastNameKey);
  static set orderLastName(String? name) => box?.write(orderLastNameKey, name);

  // order brand name
  static String? get orderBrandName => box?.read<String>(orderBrandNameKey);
  static set orderBrandName(String? name) =>
      box?.write(orderBrandNameKey, name);

  // order phone no
  static String? get orderPhoneNo => box?.read<String>(orderPhoneNoKey);
  static set orderPhoneNo(String? phoneNo) =>
      box?.write(orderPhoneNoKey, phoneNo);

  // order location
  static String? get orderLocation => box?.read<String>(orderLocationKey);
  static set orderLocation(String? location) =>
      box?.write(orderLocationKey, location);
}
