import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/packages/app/model/get_product_model.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/services/firebase_services/firebase_services.dart';
import 'package:field_king/services/notification_permission/notification_permission.dart';

class HomeScreenController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  Rx<TextEditingController> orderMeterController = TextEditingController().obs;
  RxBool isShowWithOutGst = RxBool(false);
  final enterMeterFormKey = GlobalKey<FormState>();
  RxString gstRadioButtonValue = RxString('With & Without GST');

  @override
  void onInit() {
    getPermission();
    getProducts();
    setPreference();
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

  setPreference() {
    isShowWithOutGst.value = Preference.isShowWithOutGst ?? false;
  }
}
