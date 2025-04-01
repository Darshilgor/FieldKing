import 'package:field_king/packages/app/module/chat/controller/chat_controller.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/services/app_bar.dart';
import 'package:field_king/services/common_calculation/common_calculation.dart';
import 'package:field_king/services/common_code/common_code.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key});

  final controller = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar(
        title: Text(
          'Chat',
        ),
        isLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return Gap(20);
          },
          itemCount: controller.user.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                color: AppColor.whiteColor,
                border: Border.all(
                  color: AppColor.blackColor,
                ),
              ),
              child: Row(
                children: [
                  extendedImage(
                    imageUrl: controller.user[index].profilePhoto ?? '',
                    width: 30,
                    height: 30,
                  ),
                  Gap(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${controller.user[index].firstName} ${controller.user[index].lastName}',
                      ),
                      Text(
                        controller.user[index].isActive == false
                            ? 'last active ${CommonCalculation.lastActive(
                                lastActive: controller.user[index].lastActive,
                              )}'
                            : 'Online',
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
