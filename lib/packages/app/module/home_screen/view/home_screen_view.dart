import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/packages/app/model/get_product_model.dart';
import 'package:field_king/packages/app/module/home_screen/controller/home_screen_controller.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/services/app_bar.dart';
import 'package:field_king/services/common_calculation/common_calculation.dart';

class HomeScreenView extends StatelessWidget {
  HomeScreenView({super.key});

  final controller = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar(
        title: Text(
          'Field King',
        ),
        isLeading: false,
      ),
      body: Obx(
        () => ListView.separated(
          separatorBuilder: (context, index) {
            return Gap(20);
          },
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            Product product = controller.products[index];
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: index == 0 ? 10 : 0,
                bottom: index == controller.products.length - 1 ? 20 : 0,
              ),
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      offset: Offset(1.5, 0.5),
                      spreadRadius: .5,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${product.size} ${product.type?.capitalize}${(product.type == 'flat' && product.size != '1 MM') ? '(${product.flat})' : ''} Cable',
                      style: TextStyle().medium18.textColor(
                            AppColor.blackColor,
                          ),
                    ),
                    Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Tar : ',
                              style: TextStyle().semiBold16.textColor(
                                    AppColor.blackColor,
                                  ),
                            ),
                            Text(
                              product.amp ?? '',
                              style: TextStyle().regular16.textColor(
                                    AppColor.blackColor,
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Amp : ',
                              style: TextStyle().semiBold16.textColor(
                                    AppColor.blackColor,
                                  ),
                            ),
                            Text(
                              product.amp ?? '',
                              style: TextStyle().regular16.textColor(
                                    AppColor.blackColor,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Gej : ',
                              style: TextStyle().semiBold16.textColor(
                                    AppColor.blackColor,
                                  ),
                            ),
                            Text(
                              '${product.gej} (${CommonCalculation.calculateGej(product.gej)})',
                              style: TextStyle().regular16.textColor(
                                    AppColor.blackColor,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Price : ',
                          style: TextStyle().semiBold16.textColor(
                                AppColor.blackColor,
                              ),
                        ),
                        Text(
                          '${product.price} per meter.',
                          style: TextStyle().regular16.textColor(
                                AppColor.blackColor,
                              ),
                        ),
                      ],
                    ),
                    Gap(5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          for (int i = 0; i < controller.products.length; i++) {
                            if (controller.products[i].isExpanded == true) {
                              controller.products[i].isExpanded.value = false;
                            }
                          }
                          controller.orderMeterController.value.clear();
                          controller.products[index].isExpanded.value = true;
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: Text(
                            'Add to cart',
                            style: TextStyle().medium16.textColor(
                                  AppColor.blackColor,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: controller.products[index].isExpanded.value,
                        child: Column(
                          children: [
                            Gap(10),
                            InputField(
                              controller: controller.orderMeterController.value,
                              labelText: 'Order Meter',
                              prefixIconColor: AppColor.blackColor,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if ((value ?? '').isEmpty) {
                                  return 'Pelase enter order meter';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
