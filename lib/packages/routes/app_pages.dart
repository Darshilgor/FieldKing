import 'package:field_king/packages/app/module/login/view/login_view.dart';
import 'package:field_king/packages/app/module/splash_screen/view/splash_screen_view.dart';
import 'package:field_king/packages/app/module/verify_otp/view/verify_otp_view.dart';
import 'package:field_king/packages/config.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splashScreen;

  static final routes = [
    /// Demo screen.
    GetPage(
      name: _Paths.splashScreen,
      page: () => SplashScreenView(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => LoginScreenView(),
    ),
    GetPage(
      name: _Paths.verifyOtp,
      page: () => VerifyOtpView(),
    ),
  ];
}
