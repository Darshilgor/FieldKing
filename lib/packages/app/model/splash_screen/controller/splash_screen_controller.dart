import 'package:field_king/packages/config.dart';
import 'package:field_king/packages/screen.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    callOnboardingScreen();
  }

  Future<void> callOnboardingScreen() async {
    await Future.delayed(
      const Duration(seconds: 3),
      () async {
        Get.offNamed(
          Routes.login,
        );
      },
    );
  }
}
