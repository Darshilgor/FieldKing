import 'package:field_king/packages/app/model/cart_list_model.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/services/firebase_services/firebase_services.dart';

class CartController extends GetxController {
  Rx<CartModel?> cart = Rx<CartModel?>(null);
  RxBool isApiCalled = RxBool(false);

  @override
  void onInit() {
    isApiCalled.value = false;
    fetchCart();

    super.onInit();
  }

  /// fetch cart list.
  fetchCart() async {
    cart.value = await FirebaseFirestoreServices.getCart();
    isApiCalled.value = true;
    isApiCalled.refresh();
  }

  deleteCart({int? index}) async {
    bool result = await FirebaseFirestoreServices.deleteCart(index: index);

    if (result == true) {
      cart.value?.cartList?.removeAt(index ?? 0);
    }
    cart.refresh();
  }

  createOrder() async {
    await FirebaseFirestoreServices.createOrder(
      cart: cart,
    );
  }
}
