import 'package:field_king/controller/verify_otp_controller.dart';
import 'package:field_king/services/app_color/app_colors.dart';
import 'package:field_king/services/text_label/text_label.dart';
import 'package:field_king/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({
    super.key,
  });

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  VerifyOtpController verifyOtpController = VerifyOtpController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          TextLabel.enterOtp,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                otpformfield(
                    context, verifyOtpController.controller1, true, false),
                otpformfield(
                    context, verifyOtpController.controller2, true, false),
                otpformfield(
                    context, verifyOtpController.controller3, true, false),
                otpformfield(
                    context, verifyOtpController.controller4, true, false),
                otpformfield(
                    context, verifyOtpController.controller5, true, false),
                otpformfield(
                    context, verifyOtpController.controller6, true, true),
                    PinFieldAutoFill()
              ],
            ),
            GestureDetector(
              onTap: () async {
                showprocessindicator(context);
                verifyOtpController.verifyOtpMethod(context);
              },
              child: buttonwidget(
                context,
                TextLabel.verifyOtp,
                AppColor.bgcolor1,
                AppColor.bgcolor2,
                AppColor.whitecolor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
