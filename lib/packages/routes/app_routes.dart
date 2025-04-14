part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const splashScreen = _Paths.splashScreen;
  static const login = _Paths.login;
  static const signUp = _Paths.signUp;
  static const homeScreen = _Paths.homeScreen;
  static const tabBarScreen = _Paths.tabBarScreen;
  static const editProfile = _Paths.editProfile;
  static const cartView = _Paths.cartView;
  static const paymentView = _Paths.paymentView;
  static const chatScreenView = _Paths.chatScreenView;
  static const orderAddressView = _Paths.orderAddressView;
}

abstract class _Paths {
  _Paths._();

  static const splashScreen = '/splash-screen';
  static const login = '/login-screen';
  static const signUp = '/sign-up';
  static const homeScreen = '/home-screen';
  static const tabBarScreen = '/tabbar-screen';
  static const editProfile = '/edit-profile';
  static const cartView = '/cart-view';
  static const paymentView = '/payment-view';
  static const chatScreenView = '/chat-screen-view';
  static const orderAddressView = '/order-address-view';
}
