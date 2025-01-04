import 'package:field_king/packages/config.dart';

class LoginController extends GetxController {
  Rx<TextEditingController> phoneNoController = TextEditingController().obs;
  Rx<TextEditingController> pinPutController = TextEditingController().obs;
  final loginFormKey = GlobalKey<FormState>();
  RxBool isShowOtpField = RxBool(false);
  RxBool isTimerOut = RxBool(false);
  var endTime = Rx<DateTime?>(null);
}
