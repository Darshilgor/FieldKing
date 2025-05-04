import 'package:field_king/components/unfocus_keyboard.dart';
import 'package:field_king/packages/app/model/get_product_model.dart';
import 'package:field_king/packages/app/module/home_screen/controller/home_screen_controller.dart';
import 'package:field_king/packages/app/module/tab_bar/controller/tab_bar_controller.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/packages/routes/app_pages.dart';
import 'package:field_king/services/app_bar.dart';
import 'package:field_king/services/common_calculation/common_calculation.dart';
import 'package:field_king/services/common_code/common_code.dart';
import 'package:field_king/services/general_controller/general_controller.dart';

class HomeScreenView extends StatelessWidget {
  HomeScreenView({super.key});

  final controller = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        closeKeyboard();
      },
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: CustomAppBar(
          leadingWidget: Padding(
            padding: const EdgeInsets.all(
              8,
            ),
            child: GestureDetector(
              onTap: () {
                Get.find<TabbarController>()
                    .tabBarKey
                    .currentState
                    ?.openDrawer();
              },
              child: SvgPicture.asset(
                Assets.drawerIcon,
                width: 15,
                height: 15,
                colorFilter: ColorFilter.mode(
                  AppColor.blackColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          title: Text(
            'Field King',
          ),
          isLeading: false,
          action: [
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(
                    Routes.cartView,
                  );
                },
                child: Text(
                  'Cart',
                  style: TextStyle().regular16.textColor(
                        AppColor.blackColor,
                      ),
                ),
              ),
            ),
          ],
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
                  decoration: ContainerDecoration.decoration(),
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
                      Visibility(
                        visible: GeneralController.isShowWithOutGst.value,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Price : ',
                              style: TextStyle().semiBold16.textColor(
                                    AppColor.blackColor,
                                  ),
                            ),
                            Text(
                              '${product.chipeshPrice} PM with out GST',
                              style: TextStyle().regular16.textColor(
                                    AppColor.blackColor,
                                  ),
                            ),
                          ],
                        ),
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
                          Row(
                            children: [
                              Text(
                                '${product.price} PM ',
                                style: TextStyle().regular16.textColor(
                                      AppColor.blackColor,
                                    ),
                              ),
                              Visibility(
                                visible:
                                    GeneralController.isShowWithOutGst.value,
                                child: Text(
                                  'with GST',
                                  style: TextStyle().regular16.textColor(
                                        AppColor.blackColor,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Gap(5),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            for (int i = 0;
                                i < controller.products.length;
                                i++) {
                              if (controller.products[i].isExpanded == true) {
                                controller.products[i].isExpanded.value = false;
                              }
                            }
                            controller.orderMeterController.value.clear();
                            controller.products[index].isExpanded.value = true;
                          },
                          child: customContainer(
                            title: 'Add to cart',
                            width: Get.width * 0.3,
                          ),
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: controller.products[index].isExpanded.value,
                          child: Form(
                            key: controller.enterMeterFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Visibility(
                                  visible:
                                      GeneralController.isShowWithOutGst.value,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order type : ',
                                        style: TextStyle().regular18.textColor(
                                              AppColor.blackColor,
                                            ),
                                      ),
                                      Gap(3),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: List.generate(
                                          3,
                                          (index) {
                                            final options = [
                                              '50%',
                                              'With GST',
                                              'Without GST',
                                            ];
                                            return Row(
                                              children: [
                                                Radio<String>(
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  visualDensity: VisualDensity(
                                                    horizontal: -4,
                                                    vertical: -4,
                                                  ),
                                                  value: options[index],
                                                  groupValue: controller
                                                      .gstRadioButtonValue
                                                      .value,
                                                  onChanged: (value) {
                                                    controller
                                                        .gstRadioButtonValue
                                                        .value = value!;
                                                  },
                                                ),
                                                Gap(5),
                                                Text(
                                                  options[index],
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(10),
                                InputField(
                                  controller:
                                      controller.orderMeterController.value,
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
                                Gap(20),
                                customContainer(
                                  title: 'Add',
                                  onTap: () {
                                    if (controller
                                        .enterMeterFormKey.currentState!
                                        .validate()) {
                                      controller.addToCart(
                                        flat: product.flat,
                                        gej: product.gej,
                                        orderType: GeneralController
                                                .isShowWithOutGst.value
                                            ? controller
                                                .gstRadioButtonValue.value
                                            : 'With GST',
                                        price: product.price,
                                        size: product.size,
                                        type: product.type,
                                        orderMeter: controller
                                            .orderMeterController.value.text,
                                        chipestPrice: product.chipeshPrice,
                                        index: index,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
