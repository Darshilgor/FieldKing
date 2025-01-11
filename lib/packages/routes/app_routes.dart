part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const splashScreen = _Paths.splashScreen;
  static const login = _Paths.login;
  static const signUp = _Paths.signUp;
  static const homeScreen = _Paths.homeScreen;
}

abstract class _Paths {
  _Paths._();

  static const splashScreen = '/splash-screen';
  static const login = '/login-screen';
  static const signUp = '/sign-up';
  static const homeScreen = '/home-screen';
}
