import 'package:field_king/packages/app/model/login/view/login_view.dart';
import 'package:field_king/packages/app/model/splash_screen/view/splash_screen_view.dart';
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
  ];
}
