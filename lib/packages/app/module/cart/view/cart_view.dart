import 'package:field_king/components/app_button.dart';
import 'package:field_king/packages/app/model/cart_list_model.dart';
import 'package:field_king/packages/app/module/cart/controller/cart_controller.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/services/app_bar.dart';
import 'package:field_king/services/common_calculation/common_calculation.dart';
import 'package:field_king/services/common_code/common_code.dart';
import 'package:field_king/services/firebase_services/firebase_services.dart';
import 'package:field_king/services/general_controller/general_controller.dart';

class CartView extends StatelessWidget {
  CartView({super.key});
  final controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar(
        title: Text(
          'Cart',
        ),
        isLeading: false,
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (controller.cart.value?.cartList?.length == 0)
                        ? Center(
                            child: Text(
                              'No data found',
                            ),
                          )
                        : ListView.separated(
                            separatorBuilder: (context, index) {
                              return Gap(20);
                            },
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                controller.cart.value?.cartList?.length ?? 0,
                            itemBuilder: (context, index) {
                              if ((controller.cart.value?.cartList ?? [])
                                  .isEmpty) {
                                return Center(
                                  child: Text(
                                    "No items in cart",
                                  ),
                                );
                              }
                              CartItem cartItem =
                                  ((controller.cart.value ?? CartModel())
                                          .cartList ??
                                      [])[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: index == 0 ? 10 : 0,
                                  bottom: index ==
                                          (controller.cart.value?.cartList
                                                      ?.length ??
                                                  0) -
                                              1
                                      ? 20
                                      : 0,
                                ),
                                child: Container(
                                  decoration: ContainerDecoration.decoration(),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${cartItem.size} ${cartItem.type?.capitalize}${(cartItem.type == 'flat' && cartItem.size != '1 MM') ? '(${cartItem.flat})' : ''} Cable',
                                            style:
                                                TextStyle().medium18.textColor(
                                                      AppColor.blackColor,
                                                    ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              controller.deleteCart(
                                                  index: index);
                                            },
                                            child: SvgPicture.asset(
                                              Assets.deleteIcon,
                                              width: 20,
                                              height: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Gap(10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Tar : ',
                                                style: TextStyle()
                                                    .semiBold16
                                                    .textColor(
                                                      AppColor.blackColor,
                                                    ),
                                              ),
                                              Text(
                                                cartItem.amp ?? '',
                                                style: TextStyle()
                                                    .regular16
                                                    .textColor(
                                                      AppColor.blackColor,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Amp : ',
                                                style: TextStyle()
                                                    .semiBold16
                                                    .textColor(
                                                      AppColor.blackColor,
                                                    ),
                                              ),
                                              Text(
                                                cartItem.amp ?? '',
                                                style: TextStyle()
                                                    .regular16
                                                    .textColor(
                                                      AppColor.blackColor,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Gej : ',
                                                style: TextStyle()
                                                    .semiBold16
                                                    .textColor(
                                                      AppColor.blackColor,
                                                    ),
                                              ),
                                              Text(
                                                '${cartItem.gej} (${CommonCalculation.calculateGej(cartItem.gej)})',
                                                style: TextStyle()
                                                    .regular16
                                                    .textColor(
                                                      AppColor.blackColor,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Order type : ',
                                                style: TextStyle()
                                                    .semiBold16
                                                    .textColor(
                                                      AppColor.blackColor,
                                                    ),
                                              ),
                                              Text(
                                                cartItem.orderType ?? '',
                                                style: TextStyle()
                                                    .regular16
                                                    .textColor(
                                                      AppColor.blackColor,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Visibility(
                                        visible: GeneralController
                                            .isShowWithOutGst.value,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Price : ',
                                              style: TextStyle()
                                                  .semiBold16
                                                  .textColor(
                                                    AppColor.blackColor,
                                                  ),
                                            ),
                                            Text(
                                              '${cartItem.chipestPrice} PM with out GST',
                                              style: TextStyle()
                                                  .regular16
                                                  .textColor(
                                                    AppColor.blackColor,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Price : ',
                                            style: TextStyle()
                                                .semiBold16
                                                .textColor(
                                                  AppColor.blackColor,
                                                ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${cartItem.price} PM ',
                                                style: TextStyle()
                                                    .regular16
                                                    .textColor(
                                                      AppColor.blackColor,
                                                    ),
                                              ),
                                              Visibility(
                                                visible: GeneralController
                                                    .isShowWithOutGst.value,
                                                child: Text(
                                                  'with GST',
                                                  style: TextStyle()
                                                      .regular16
                                                      .textColor(
                                                        AppColor.blackColor,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Meter : ',
                                            style: TextStyle()
                                                .semiBold16
                                                .textColor(
                                                  AppColor.blackColor,
                                                ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${cartItem.orderMeter} Meter',
                                                style: TextStyle()
                                                    .regular16
                                                    .textColor(
                                                      AppColor.blackColor,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Total price : ',
                                            style: TextStyle()
                                                .semiBold16
                                                .textColor(
                                                  AppColor.blackColor,
                                                ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                (cartItem.orderType ==
                                                        'With GST')
                                                    ? (double.parse(cartItem.orderMeter ?? '0') *
                                                            double.parse(
                                                                cartItem.price ??
                                                                    '0'))
                                                        .toStringAsFixed(
                                                            2) // Convert to 2 decimal places
                                                    : cartItem.orderType ==
                                                            '50%'
                                                        ? (((double.parse(cartItem.orderMeter ?? '0') / 2) * double.parse(cartItem.chipestPrice ?? '0')) +
                                                                ((double.parse(cartItem.orderMeter ?? '0') /
                                                                        2) *
                                                                    double.parse(
                                                                        cartItem.price ??
                                                                            '0')))
                                                            .toStringAsFixed(2)
                                                        : (double.parse(cartItem.orderMeter ?? '0') *
                                                                double.parse(cartItem.chipestPrice ?? '0'))
                                                            .toStringAsFixed(2),
                                                style: TextStyle()
                                                    .regular16
                                                    .textColor(
                                                        AppColor.blackColor),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
            CommonAppButton(
              text: 'Send Otp',
              onTap: () {
                
              },
            ),
            Gap(
              Get.height * 0.2,
            ),
          ],
        ),
      ),
    );
  }
}
