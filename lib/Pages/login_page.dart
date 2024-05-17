import 'package:field_king/controller/send_otp_controller.dart';
import 'package:field_king/services/app_color/app_colors.dart';
import 'package:field_king/services/text_label/text_label.dart';
import 'package:field_king/services/text_style/text_style.dart';
import 'package:field_king/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final SendOtpController controller = Get.put(SendOtpController());

  FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              TextLabel.logIn,
              style: TextStyleClass.headingtext.copyWith(
                fontSize: 30,
              ),
            ),
            Column(
              children: [
                formfield(
                  context,
                  TextLabel.enterMobileNumber,
                  TextLabel.hintMobileNumber,
                  controller.mobileNumberController,
                  10,
                  '', // countertext
                  TextInputType.phone,
                  onchange,
                  onfieldsubmitted,
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                  focusNode: myFocusNode,
                  readOnly: false,
                ),
                GestureDetector(
                  onTap: () {
                    controller.signIn(context);
                  },
                  child: buttonwidget(
                    context,
                    TextLabel.sendOtp,
                    AppColor.bgcolor1,
                    AppColor.bgcolor2,
                    Colors.white,
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      (controller.countDown.value != 0)
                          ? Text(
                              controller.countDown.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: (controller.countDown.value != 0 ||
                                        controller.OtpSend.value == false)
                                    ? FontWeight.w100
                                    : FontWeight.w600,
                              ),
                            )
                          : Container(),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          controller.reSendOtp(context);
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            TextLabel.resendOtp,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: (controller.countDown.value != 0 ||
                                      controller.OtpSend.value == false)
                                  ? FontWeight.w100
                                  : FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 180,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  onchange(String p1) {}

  onfieldsubmitted(String p1) {}
}
