import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/packages/app/model/get_product_model.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/services/notification_permission/notification_permission.dart';

class HomeScreenController extends GetxController {
  final List<Product> products = [];
  @override
  void onInit() {
    getPermission();

    getProductList();
    super.onInit();
  }

  Future<void> getPermission() async {
    await NotificationPermission.requestNotificationPermission();
    await ContactPermission.requestContactPermission();
  }

  Future<void> getProductList() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('products').get();

      for (var doc in snapshot.docs) {
        print("Document ID: ${doc.id}");
        print("Raw Data: ${doc.data()}");

        final data = doc.data() as Map<String, dynamic>;
        final product = Product.fromMap(doc.id, data);
        products.add(product);
        print('product length is');
        print(products.length);
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
  }
}
