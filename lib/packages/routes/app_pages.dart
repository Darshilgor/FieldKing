import 'package:field_king/packages/app/module/cart/view/cart_view.dart';
import 'package:field_king/packages/app/module/chat/chat_screen/view/chat_screen_view.dart';
import 'package:field_king/packages/app/module/home_screen/view/home_screen_view.dart';
import 'package:field_king/packages/app/module/login/view/login_view.dart';
import 'package:field_king/packages/app/module/order_address/view/order_address_view.dart';
import 'package:field_king/packages/app/module/order_history/order_history_details/view/order_history_details_view.dart';
import 'package:field_king/packages/app/module/order_history/view/order_history_view.dart';
import 'package:field_king/packages/app/module/payment/view/payment_view.dart';
import 'package:field_king/packages/app/module/profile/edit_profile/view/edit_profile_view.dart';
import 'package:field_king/packages/app/module/sign_up/view/sign_up_screen_view.dart';
import 'package:field_king/packages/app/module/splash_screen/view/splash_screen_view.dart';
import 'package:field_king/packages/app/module/tab_bar/view/tab_bar_view.dart';
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
      name: _Paths.signUp,
      page: () => SignUpScreenView(),
    ),
    GetPage(
      name: _Paths.homeScreen,
      page: () => HomeScreenView(),
    ),
    GetPage(
      name: _Paths.tabBarScreen,
      page: () => TabBarScreenView(),
    ),
    GetPage(
      name: _Paths.editProfile,
      page: () => EditProfileView(),
    ),
    GetPage(
      name: _Paths.cartView,
      page: () => CartView(),
    ),
    GetPage(
      name: _Paths.paymentView,
      page: () => PaymentView(),
    ),
    GetPage(
      name: _Paths.chatScreenView,
      page: () => ChatScreenView(),
    ),
    GetPage(
      name: _Paths.orderAddressView,
      page: () => OrderAddressView(),
    ),
    GetPage(
      name: _Paths.orderHistoryView,
      page: () => OrderHistoryView(),
    ),
    GetPage(
      name: _Paths.orderHistoryDetailsView,
      page: () => OrderHistoryDetailsView(),
    ),
  ];
}
