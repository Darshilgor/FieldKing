import 'package:field_king/components/unfocus_keyboard.dart';
import 'package:field_king/packages/app/model/get_product_model.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/services/firebase_services/firebase_services.dart';
import 'package:field_king/services/global_variable/global_variable.dart';
import 'package:field_king/services/notification_permission/notification_permission.dart';

class HomeScreenController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  Rx<TextEditingController> orderMeterController = TextEditingController().obs;
  final enterMeterFormKey = GlobalKey<FormState>();
  RxString gstRadioButtonValue = RxString('50%');

  @override
  void onInit() {
    getPermission();
    getProducts();
    super.onInit();
  }

  Future<void> getPermission() async {
    await NotificationPermission.requestNotificationPermission();
    await ContactPermission.requestContactPermission();
  }

  getProducts() async {
    try {
      List<Product> productList =
          await FirebaseFirestoreServices.getProductList();
      products.addAll(productList);
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  addToCart({
    String? flat,
    String? gej,
    String? orderType,
    String? price,
    String? size,
    String? type,
    String? orderMeter,
    String? chipestPrice,
    int? index,
  }) async {
    await FirebaseFirestoreServices.addToCart(
      cableDetails: {
        'amp': '11',
        'flat': flat,
        'gej': gej,
        'orderType': orderType,
        'price': price,
        'size': size,
        'type': type,
        'orderMeter': orderMeter,
        'chipestPrice': chipestPrice,
      },
    );
    GlobalVariable.isUpdateCart.value = true;
    closeKeyboard();
    products[index ?? 0].isExpanded.value = false;
  }
}
