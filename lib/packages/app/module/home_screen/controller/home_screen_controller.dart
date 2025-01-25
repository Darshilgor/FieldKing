import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/packages/app/model/get_product_model.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/services/notification_permission/notification_permission.dart';

class HomeScreenController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  @override
  void onInit() {
    getPermission();

    // getProductList();
    super.onInit();
  }

  Future<void> getPermission() async {
    await NotificationPermission.requestNotificationPermission();
    await ContactPermission.requestContactPermission();
  }

  // Future<void> getProductList() async {
  //   try {
  //     final snapshot =
  //         await FirebaseFirestore.instance.collection('Products').get();

  //     for (var doc in snapshot.docs) {
  //       final data = doc.data() as Map<String, dynamic>;
  //       final product = Product.fromMap(doc.id, data);
  //       products.add(product);
  //     }

  //     print('Products fetched successfully!');
  //     print('Total products: ${products.length}');
  //   } catch (e) {
  //     print("Error fetching products: $e");
  //   }
  // }
  Future<List<Product>> getProducts() async {
    try {
      // Fetch all documents from the 'product' collection
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Products').get();

      // Parse the documents into Product models
      return snapshot.docs.map((doc) {
        // Extract the document data
        final data = doc.data() as Map<String, dynamic>;

        // Create Product model from Firestore data
        return Product.fromMap(doc.id, data);
      }).toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }
}
