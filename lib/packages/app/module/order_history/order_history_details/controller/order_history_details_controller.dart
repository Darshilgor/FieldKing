import 'package:field_king/packages/app/model/order_history_model.dart';
import 'package:field_king/packages/config.dart';

class OrderHistoryDetailsController extends GetxController {
  RxList<OrderHistoryItem> orderHistoryList = RxList<OrderHistoryItem>();
  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  getArgument() {
    var argument = Get.arguments;
    if (argument != null) {
      orderHistoryList.value = argument['orderHistory'];
    }
  }
}
