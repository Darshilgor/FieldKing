import 'package:field_king/Pages/login_page.dart';
import 'package:field_king/controller/send_otp_controller.dart';
import 'package:field_king/services/app_color/app_colors.dart';
import 'package:field_king/services/text_style/text_style.dart';
import 'package:field_king/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SendOtpController signupController = Get.put(SendOtpController());
  FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        title: Text(
          'Sign Up',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            formfield(
              context,
              'Enter First Name',
              'Field',
              signupController.firstNameController,
              20,
              '',
              TextInputType.name,
              onchange,
              onfieldsubmitted,
              FilteringTextInputFormatter.singleLineFormatter,
              LengthLimitingTextInputFormatter(20),
            ),
            formfield(
              context,
              'Enter Last Name',
              'King',
              signupController.lastNameController,
              20,
              '',
              TextInputType.name,
              onchange,
              onfieldsubmitted,
              FilteringTextInputFormatter.singleLineFormatter,
              LengthLimitingTextInputFormatter(20),
            ),
            formfield(
              context,
              'Enter Your Brand Name',
              'Field King Brand',
              signupController.brandNameController,
              20,
              '',
              TextInputType.name,
              onchange,
              onfieldsubmitted,
              FilteringTextInputFormatter.singleLineFormatter,
              LengthLimitingTextInputFormatter(20),
            ),
            formfield(
                context,
                'Enter Mobile Number',
                '9409529203',
                signupController.mobileNumberController,
                10,
                '',
                TextInputType.number,
                onchange,
                onfieldsubmitted,
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
                focusNode: _focusNode),
            GestureDetector(
              onTap: () {
                signupController.signUp(context);
              },
              child: buttonwidget(
                context,
                'Send Otp',
                AppColor.bgcolor1,
                AppColor.bgcolor2,
                AppColor.whitecolor,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        LoginPage(),
                      );
                    },
                    child: Text(
                      'Login',
                      style: Style.textstyle2.copyWith(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      (signupController.countDown.value != 0)
                          ? Text(
                              signupController.countDown.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: (signupController.countDown.value !=
                                            0 ||
                                        signupController.OtpSend.value == false)
                                    ? FontWeight.w100
                                    : FontWeight.w600,
                              ),
                            )
                          : Container(),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          signupController.reSendOtp(context);
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            'Resend OTP',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: (signupController.countDown.value !=
                                          0 ||
                                      signupController.OtpSend.value == false)
                                  ? FontWeight.w100
                                  : FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onchange(String value) {}

  void onfieldsubmitted(String? value) {}
}
