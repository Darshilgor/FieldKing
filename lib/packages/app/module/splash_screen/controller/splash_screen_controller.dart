import 'package:field_king/packages/config.dart';
import 'package:field_king/packages/screen.dart';
import 'package:field_king/services/firebase_services/firebase_services.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    callOnboardingScreen();
    startUpFunction();
  }

  Future<void> callOnboardingScreen() async {
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () async {
        Preference.isLogin == true
            ? Get.offAllNamed(Routes.tabBarScreen)
            : Get.offAllNamed(Routes.login);
      },
    );
  }

  startUpFunction() {
    FirebaseFirestoreServices.getIsShowWithOutGst();
    FirebaseFirestoreServices.getUser();
  }
}
