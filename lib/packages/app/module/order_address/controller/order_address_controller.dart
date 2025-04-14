import 'package:field_king/packages/app/model/cart_list_model.dart';
import 'package:field_king/packages/config.dart';

class OrderAddressController extends GetxController {
  Rx<TextEditingController> phoneNoController = TextEditingController().obs;
  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> brandNameController = TextEditingController().obs;
  Rx<TextEditingController> locationController = TextEditingController().obs;
  Rx<CartModel?> cart = Rx<CartModel?>(null);
  final orderDetailsKey = GlobalKey<FormState>();

  @override
  void onInit() {
    getArgument();
    getPreferences();
    super.onInit();
  }

  getPreferences() async {
    String? firstName = Preference.orderFirstName;
    bool? isStoredOrderDetails = false;
    if ((firstName ?? '').isNotEmpty || firstName != '') {
      isStoredOrderDetails = true;
    } else {
      isStoredOrderDetails = false;
    }
    phoneNoController.value.text = isStoredOrderDetails
        ? await Preference.orderPhoneNo ?? ''
        : await Preference.phoneNumber ?? '';
    firstNameController.value.text = isStoredOrderDetails
        ? await Preference.orderFirstName ?? ''
        : await Preference.firstName ?? '';
    lastNameController.value.text = isStoredOrderDetails
        ? await Preference.orderLastName ?? ''
        : await Preference.lastName ?? '';
    brandNameController.value.text = isStoredOrderDetails
        ? await Preference.orderBrandName ?? ''
        : await Preference.brandName ?? '';
    locationController.value.text = isStoredOrderDetails
        ? await Preference.orderBrandName ?? ''
        : await Preference.address ?? '';
  }

  getArgument() {
    var argument = Get.arguments;
    if (argument != null) {
      cart = argument['cart'];
    }
  }
}
