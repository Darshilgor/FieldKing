import 'package:field_king/packages/app/model/cart_list_model.dart';
import 'package:field_king/packages/app/module/tab_bar/controller/tab_bar_controller.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/services/firebase_services/firebase_services.dart';
import 'package:field_king/services/global_variable/global_variable.dart';

class CartController extends GetxController {
  Rx<CartModel?> cart = Rx<CartModel?>(null);

  @override
  void onInit() {
    fetchCart();
    ever(
      Get.find<TabbarController>().currentIndex,
      (index) {
        if (index == 2) {
          if (GlobalVariable.isUpdateCart.value) {
            fetchCart();
            print('inside the if condition');
          } else {
            print('inside the else condition');
          }
        }
      },
    );
    super.onInit();
  }

  fetchCart() async {
    cart.value = await FirebaseFirestoreServices.getCart();
  }

  deleteCart({int? index}) async {
    bool result = await FirebaseFirestoreServices.deleteCart(index: index);

    if (result == true) {
      cart.value?.cartList?.removeAt(index ?? 0);
    }
    cart.refresh();
  }
}
