import 'package:field_king/services/app_bar.dart';
import 'package:field_king/services/app_color/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

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
          Text(
            'data',
          ),
        ],
      ),
    );
  }
}
