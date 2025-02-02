import 'package:field_king/packages/app/model/cart_list_model.dart';
import 'package:field_king/packages/app/module/cart/controller/cart_controller.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/services/app_bar.dart';
import 'package:image_cropper/image_cropper.dart';

class CartView extends StatelessWidget {
  CartView({super.key});
  final controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar(
        title: Text(
          'Cart',
        ),
        isLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              ((controller.cart.value ?? CartModel()).cartList ?? [])
                  .length
                  .toString(),
            ),
          ),
        ],
      ),
    );
  }
}
