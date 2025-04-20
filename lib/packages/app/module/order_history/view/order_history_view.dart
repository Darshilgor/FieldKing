import 'package:field_king/packages/app/module/order_history/controller/order_history_controller.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/packages/routes/app_pages.dart';
import 'package:field_king/services/app_bar.dart';
import 'package:field_king/services/common_code/common_code.dart';
import 'package:field_king/services/date_utils/date_utils.dart';
import 'package:intl/intl.dart';

class OrderHistoryView extends StatelessWidget {
  OrderHistoryView({super.key});

  final controller = Get.put(OrderHistoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar(
        title: Text(
          'Order history',
        ),
        isLeading: true,
      ),
      body:
      /// add push from vs code.
       Obx(
        () => ListView.builder(
          itemCount: controller.orderHistoryList.length,
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          itemBuilder: (context, index) {
            var order = controller.orderHistoryList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(
                    Routes.orderHistoryDetailsView,
                    arguments: {
                      'orderHistory': order.order,
                    },
                  );
                },
                child: Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 12,
                  ),
                  decoration: ContainerDecoration.decoration(),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Order Id : ',
                            style: TextStyle(
                              color: AppColor.blackColor,
                            ),
                          ),
                          Text(
                            order.orderId ?? '',
                            style: TextStyle(
                              color: AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                      Gap(5),
                      Row(
                        children: [
                          Text(
                            'Order date : ',
                            style: TextStyle(
                              color: AppColor.blackColor,
                            ),
                          ),
                          Text(
                            DateUtilities.formatFirestoreDate(
                              order.createdAt,
                            ),
                            style: TextStyle(
                              color: AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                      Gap(5),
                      Row(
                        children: [
                          Text(
                            'Total sub order : ',
                            style: TextStyle(
                              color: AppColor.blackColor,
                            ),
                          ),
                          Text(
                            (order.order ?? []).length.toString(),
                            style: TextStyle(
                              color: AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                      Gap(5),
                      Row(
                        children: [
                          Text(
                            'Total order meter : ',
                            style: TextStyle(
                              color: AppColor.blackColor,
                            ),
                          ),
                          Text(
                            order.totalOrderMeter ?? '',
                            style: TextStyle(
                              color: AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                      Gap(5),
                      Row(
                        children: [
                          Text(
                            'Total order amount : ',
                            style: TextStyle(
                              color: AppColor.blackColor,
                            ),
                          ),
                          Text(
                            order.totalOrderAmout ?? '',
                            style: TextStyle(
                              color: AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                      Gap(5),
                      Row(
                        children: [
                          Text(
                            'Payment type : ',
                            style: TextStyle(
                              color: AppColor.blackColor,
                            ),
                          ),
                          Text(
                            order.paymentType ?? '',
                            style: TextStyle(
                              color: AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                      Gap(5),
                      Row(
                        children: [
                          Text(
                            'Payment status : ',
                            style: TextStyle(
                              color: AppColor.blackColor,
                            ),
                          ),
                          Text(
                            order.paymentStatus.toString(),
                            style: TextStyle(
                              color: AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
