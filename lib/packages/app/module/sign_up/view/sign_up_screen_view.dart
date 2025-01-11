import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/components/app_button.dart';
import 'package:field_king/components/unfocus_keyboard.dart';
import 'package:field_king/packages/app/module/sign_up/controller/sign_up_screen_controller.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/services/firebase_services/firebase_services.dart';
import 'package:field_king/services/toast_message/toast_message.dart';

class SignUpScreenView extends StatelessWidget {
  SignUpScreenView({super.key});

  final controller = Get.put(SignUpScreenController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unFocusKeyboard(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Form(
            key: controller.signUpFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Gap(Get.height * 0.1),
                  Text(
                    'Fill your details to continue.',
                    style: TextStyle().bold26.textColor(
                          AppColor.blackColor,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  Gap(Get.height * 0.2),
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
                        return 'Please enter first name.';
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
                        return 'Please enter last name.';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(20),
                  InputField(
                    controller: controller.brandNameController.value,
                    labelText: 'Brand Name',
                    hintText: 'Field King',
                    prefixIcon: Assets.brandNameIcon,
                    isPngPrefixIcon: true,
                    prefixIconColor: AppColor.blackColor,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Please enter brand name.';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(20),
                  InputField(
                    disable: true,
                    readOnly: true,
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
                        return 'Please enter phone number.';
                      } else if (value?.length != 10) {
                        return 'Please enter valid phone number.';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(40),
                  Obx(
                    () => CommonAppButton(
                      text: 'Submit',
                      buttonType: controller.isSubmitBtnLoading.value
                          ? ButtonType.progress
                          : ButtonType.enable,
                      onTap: () {
                        if (controller.signUpFormKey.currentState!.validate()) {
                          unFocusKeyboard();
                          controller.isSubmitBtnLoading.value = true;
                          controller.addUser();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
