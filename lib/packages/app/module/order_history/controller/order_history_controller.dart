import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/packages/app/model/order_history_model.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/services/firebase_services/firebase_services.dart';

class OrderHistoryController extends GetxController {
  RxList<OrderHistoryModel> orderHistoryList = <OrderHistoryModel>[].obs;

  @override
  void onInit() {
    getOrderHistory();
    super.onInit();
  }

  getOrderHistory() {
    orderHistoryList.value = FirebaseFirestoreServices.getOrderHistory();

    orderHistoryList.refresh();
  }
}
