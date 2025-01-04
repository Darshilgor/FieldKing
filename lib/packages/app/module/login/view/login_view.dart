import 'package:field_king/components/app_button.dart';
import 'package:field_king/components/bottom_sheet.dart';
import 'package:field_king/components/pin_put.dart';
import 'package:field_king/components/unfocus_keyboard.dart';
import 'package:field_king/packages/app/module/login/controller/login_controller.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/packages/routes/app_pages.dart';

class LoginScreenView extends StatelessWidget {
  LoginScreenView({super.key});

  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unFocusKeyboard(),
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SafeArea(
            child: Form(
              key: controller.loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Gap(50),
                  Text(
                    'Login',
                    style: TextStyle().bold26.textColor(
                          AppColor.blackColor,
                        ),
                  ),
                  Gap(
                    Get.height * 0.25,
                  ),
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
                  CommonAppButton(
                    text: 'Send Otp',
                    buttonType: ButtonType.enable,
                    onTap: () {
                      // if (controller.loginFormKey.currentState!.validate()) {
                      bottomSheet(
                        buttonTitle: 'Verify',
                        context: context,
                        isShowResendCode: true,
                        formKey: controller.loginFormKey,
                        widgetList: [
                          otpWidget(
                            controller: controller.pinPutController.value,
                          ),
                        ],
                        onTap: () {},
                       
                      );
                      // }
                    },
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
