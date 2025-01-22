import 'package:field_king/components/bottom_sheet.dart';
import 'package:field_king/components/pin_put.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/packages/routes/app_pages.dart';
import 'package:field_king/services/firebase_services/firebase_services.dart';
import 'package:field_king/services/notification_permission/notification_permission.dart';
import 'package:field_king/services/toast_message/toast_message.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginController extends GetxController {
  Rx<TextEditingController> phoneNoController = TextEditingController().obs;
  Rx<TextEditingController> pinPutController = TextEditingController().obs;
  final loginFormKey = GlobalKey<FormState>();
  RxBool isShowOtpField = RxBool(false);
  RxBool isTimerOut = RxBool(false);
  var endTime = Rx<DateTime?>(null);
  RxBool isSendOtpBtnLoad = RxBool(false);
  RxBool isVerifyOtpBtnLoad = RxBool(false);

  @override
  void onInit() {
    super.onInit();
  }

  sendOtpFunction({
    BuildContext? context,
    required Function(String) onCodeSentFunction,
  }) {
    FirebaseAuthServices.sendOTP(
      phoneNumber: '+91${phoneNoController.value.text}',
      onError: (e) {
        print(e);
        isSendOtpBtnLoad.value = false;
        ToastMessage.getSnackToast(
          message: e.message,
        );
      },
      onCodeSent: (verificationId) => onCodeSentFunction(verificationId),
    );
  }

  verifyOtpFunction({String? verificationId}) {
    FirebaseAuthServices.verifyOTP(
      verificationId: verificationId ?? '',
      otp: pinPutController.value.text,
      onVerified: (value) {
        isVerifyOtpBtnLoad.value = false;
        isVerifyOtpBtnLoad.refresh();
        Preference.isOtpVerified = true;
        Preference.phoneNumber = phoneNoController.value.text;
        Get.back();
        Get.offAllNamed(
          Routes.signUp,
          arguments: {
            'phoneNo': phoneNoController,
          },
        );
      },
      onError: (e) {
        print(e);
        isVerifyOtpBtnLoad.value = false;
        isVerifyOtpBtnLoad.refresh();
        ToastMessage.getSnackToast(
          message: 'Invalid OTP, Please enter correct OTP.',
        );
      },
    );
  }
}
