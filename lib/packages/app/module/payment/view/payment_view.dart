import 'package:field_king/components/app_button.dart';
import 'package:field_king/packages/app/model/cart_list_model.dart';
import 'package:field_king/packages/app/module/payment/controller/payment_controller.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/services/app_bar.dart';
import 'package:field_king/services/app_color/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:googleapis/androidpublisher/v3.dart';

class PaymentView extends StatelessWidget {
  PaymentView({super.key});

  final controller = Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar(
        title: Text(
          'Payment',
        ),
        isLeading: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.cart.value?.cartList?.length,
                    itemBuilder: (context, index) {
                      CartItem? item = controller.cart.value?.cartList?[index];
                      String? type = item?.type;
                      String? subType = item?.type == 'flat' ? item?.flat : '';
                      String? subTypeWithCouse =
                          (subType ?? '').isNotEmpty ? '($subType)' : '';
                      String? orderType = item?.orderType == '50%'
                          ? '50% with GST'
                          : item?.orderType;

                      controller.totalOrderMeter?.value +=
                          double.parse(item?.orderMeter ?? '0');

                      controller.totalOrderAmount?.value += (item?.orderType ==
                              'With GST')
                          ? ((double.tryParse(item?.orderMeter ?? '0') ?? 0) *
                              (double.tryParse(item?.price ?? '0') ?? 0) *
                              1.18)
                          : (item?.orderType == '50%')
                              ? (((double.tryParse(item?.orderMeter ?? '0') ?? 0) /
                                          2) *
                                      (double.tryParse(
                                              item?.chipestPrice ?? '0') ??
                                          0)) +
                                  ((((double.tryParse(item?.orderMeter ?? '0') ??
                                                  0) /
                                              2) *
                                          (double.tryParse(item?.price ?? '0') ??
                                              0)) *
                                      1.18)
                              : (double.tryParse(item?.orderMeter ?? '0') ?? 0) *
                                  (double.tryParse(item?.chipestPrice ?? '0') ??
                                      0); 

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${item?.size} ${type?.capitalize} ${subTypeWithCouse}',
                                  style: TextStyle().regular18.textColor(
                                        AppColor.blackColor,
                                      ),
                                ),
                                Text(
                                  orderType ?? '',
                                  style: TextStyle().regular14.textColor(
                                        AppColor.blackColor,
                                      ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      children: [
                                        Text((orderType == '50% with GST')
                                            ? ((double.parse(item?.orderMeter ??
                                                        '0')) /
                                                    2)
                                                .toString()
                                            : (item?.orderMeter ?? '0')),
                                        Text(
                                          ' x ',
                                        ),
                                        Text(
                                          (orderType == '50% with GST')
                                              ? (item?.price ?? '')
                                              : orderType == 'With GST'
                                                  ? (item?.price ?? '')
                                                  : (item?.chipestPrice ?? ''),
                                        ),
                                        Visibility(
                                          visible:
                                              orderType == '50% with GST' ||
                                                  orderType == 'With GST',
                                          child: Text('  +  18%'),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible:
                                          item?.orderType == '50% with GST',
                                      child: Text(
                                        (((double.tryParse(item?.orderMeter ??
                                                            '0') ??
                                                        0) /
                                                    2) *
                                                (double.tryParse(
                                                        item?.price ?? '0') ??
                                                    0))
                                            .toStringAsFixed(2),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  (item?.orderType == 'With GST')
                                      ? (double.parse(item?.orderMeter ?? '0') *
                                              double.parse(item?.price ?? '0') *
                                              1.18)
                                          .toStringAsFixed(2)
                                      : item?.orderType == '50%'
                                          ? ((double.parse(item?.orderMeter ??
                                                          '0') /
                                                      2) *
                                                  double.parse(
                                                      item?.price ?? '0') *
                                                  1.18)
                                              .toStringAsFixed(2)
                                          : (double.parse(
                                                      item?.orderMeter ?? '0') *
                                                  double.parse(
                                                      item?.chipestPrice ??
                                                          '0'))
                                              .toStringAsFixed(2),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: orderType == '50% with GST',
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text((orderType == '50% with GST')
                                          ? ((double.parse(item?.orderMeter ??
                                                      '0')) /
                                                  2)
                                              .toString()
                                          : (item?.orderMeter ?? '0')),
                                      Text(
                                        ' x ',
                                      ),
                                      Text(
                                        item?.chipestPrice ?? '',
                                      ),
                                    ],
                                  ),
                                  Text(
                                    (item?.orderType == 'With GST')
                                        ? (double.parse(item?.orderMeter ?? '0') *
                                                double.parse(
                                                    item?.price ?? '0'))
                                            .toStringAsFixed(2)
                                        : item?.orderType == '50%'
                                            ? (((double.parse(
                                                            item?.orderMeter ??
                                                                '0') /
                                                        2) *
                                                    double.parse(
                                                        item?.chipestPrice ??
                                                            '0')))
                                                .toStringAsFixed(2)
                                            : (double.parse(item?.orderMeter ?? '0') *
                                                    double.parse(
                                                        item?.chipestPrice ??
                                                            '0'))
                                                .toStringAsFixed(2),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: index ==
                                  (controller.cart.value?.cartList?.length ??
                                          0) -
                                      1,
                              child: Column(
                                children: [
                                  Gap(10),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total order meter',
                                      ),
                                      Text(
                                        controller.totalOrderMeter?.value
                                                .toString() ??
                                            '',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total price',
                                      ),
                                      Text(
                                        (controller.totalOrderAmount ??
                                                RxDouble(0.0))
                                            .value
                                            .toStringAsFixed(2),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: CommonAppButton(
              buttonType: ButtonType.enable,
              text: 'Continue',
              buttonColor: AppColor.blackColor,
              onTap: () {
                controller.createOrder();
              },
              width: Get.width,
              textColor: AppColor.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
