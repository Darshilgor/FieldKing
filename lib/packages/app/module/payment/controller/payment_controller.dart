import 'package:field_king/packages/app/model/cart_list_model.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/packages/routes/app_pages.dart';
import 'package:field_king/services/firebase_services/firebase_services.dart';

class PaymentController extends GetxController {
  Rx<CartModel?> cart = Rx<CartModel?>(null);
  RxDouble? totalOrderMeter = RxDouble(0.0);
  RxDouble? totalOrderAmount = RxDouble(0.0);

  Rx<TextEditingController> phoneNoController = TextEditingController().obs;
  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> brandNameController = TextEditingController().obs;
  Rx<TextEditingController> locationController = TextEditingController().obs;

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  getArgument() {
    var argument = Get.arguments;
    if (argument != null) {
      cart = argument['cart'];
      firstNameController.value.text = argument['firstName'];
      lastNameController.value.text = argument['lastName'];
      brandNameController.value.text = argument['brandName'];
      phoneNoController.value.text = argument['phoneNumber'];
      locationController.value.text = argument['location'];
    }
  }

  createOrder() async {
    await FirebaseFirestoreServices.createOrder(
      cart: cart,
      firstname: firstNameController.value.text,
      lastName: lastNameController.value.text,
      brandName: brandNameController.value.text,
      phoneNo: phoneNoController.value.text,
      location: locationController.value.text,
    );
    Get.until(
      (route) => route.settings.name == Routes.tabBarScreen,
    );
  }
}
