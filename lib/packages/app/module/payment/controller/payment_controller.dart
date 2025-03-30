import 'package:field_king/packages/app/model/cart_list_model.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/packages/routes/app_pages.dart';
import 'package:field_king/services/firebase_services/firebase_services.dart';

class PaymentController extends GetxController {
  Rx<CartModel?> cart = Rx<CartModel?>(null);
  RxDouble? totalOrderMeter = RxDouble(0.0);
  RxDouble? totalOrderAmount = RxDouble(0.0);
  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  getArgument() {
    var argument = Get.arguments;
    if (argument != null) {
      cart = argument['cart'];
    }
  }

  createOrder() async {
    await FirebaseFirestoreServices.createOrder(
      cart: cart,
    );
    Get.until(
      (route) => route.settings.name == Routes.tabBarScreen,
    );
  }
}
