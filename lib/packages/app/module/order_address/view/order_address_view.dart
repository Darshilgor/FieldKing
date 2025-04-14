import 'package:field_king/components/app_button.dart';
import 'package:field_king/components/text_form_field.dart';
import 'package:field_king/packages/app/module/order_address/controller/order_address_controller.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/packages/routes/app_pages.dart';
import 'package:field_king/services/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

class OrderAddressView extends StatelessWidget {
  OrderAddressView({super.key});

  final controller = Get.put(OrderAddressController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar(
        title: Text(
          'Order details',
        ),
        isLeading: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Obx(
                  () => Form(
                    key: controller.orderDetailsKey,
                    child: Column(
                      children: [
                        InputField(
                          controller: controller.firstNameController.value,
                          labelText: 'First Name',
                          hintText: 'KishorBhai',
                          prefixIcon: Assets.accountIcon,
                          prefixIconColor: AppColor.blackColor,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return 'Please enter first name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Gap(20),
                        InputField(
                          controller: controller.lastNameController.value,
                          labelText: 'Last Name',
                          hintText: 'Gor',
                          prefixIcon: Assets.accountIcon,
                          prefixIconColor: AppColor.blackColor,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return 'Please enter last name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Gap(20),
                        InputField(
                          controller: controller.brandNameController.value,
                          labelText: 'Brand Name',
                          hintText: 'Gor',
                          prefixIcon: Assets.brandNameIcon,
                          prefixIconColor: AppColor.blackColor,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return 'Please enter brand name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Gap(20),
                        InputField(
                          controller: controller.phoneNoController.value,
                          labelText: 'Phone No',
                          hintText: '9409529203',
                          prefixIcon: Assets.phoneIcon,
                          prefixIconColor: AppColor.blackColor,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          maxLength: 10,
                          validator: (value) {
                            if (value?.length == 0) {
                              return 'Please enter phone number';
                            } else if (value?.length != 10) {
                              return 'Please enter valid phone number';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Gap(20),
                        InputField(
                          controller: controller.locationController.value,
                          labelText: 'Address',
                          hintText: 'Address',
                          prefixIcon: Assets.lcoationIcon,
                          isPngPrefixIcon: true,
                          prefixIconColor: AppColor.blackColor,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return 'Please enter address';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
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
                if (controller.orderDetailsKey.currentState!.validate()) {
                  Get.toNamed(
                    Routes.paymentView,
                    arguments: {
                      'cart': controller.cart,
                      'firstName': controller.firstNameController.value.text,
                      'lastName': controller.lastNameController.value.text,
                      'brandName': controller.brandNameController.value.text,
                      'phoneNumber': controller.phoneNoController.value.text,
                      'location': controller.locationController.value.text,
                    },
                  );
                }
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
