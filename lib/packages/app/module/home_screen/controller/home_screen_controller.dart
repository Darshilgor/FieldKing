import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/packages/app/model/get_product_model.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/services/notification_permission/notification_permission.dart';

class HomeScreenController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  Rx<TextEditingController> orderMeterController = TextEditingController().obs;


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
    print('inside the get product.');
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Products').get();

      final product = snapshot.docs.map(
        (doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Product.fromMap(doc.id, data);
        },
      ).toList();
      products.assignAll(product);

      print('product list lenght is');
      print(products.length);
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }
}
