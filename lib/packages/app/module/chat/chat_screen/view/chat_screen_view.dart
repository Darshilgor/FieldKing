import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/components/unfocus_keyboard.dart';
import 'package:field_king/packages/app/module/chat/chat_screen/controller/chat_screen_controller.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/packages/routes/app_pages.dart';
import 'package:field_king/services/app_bar.dart';
import 'package:field_king/services/app_color/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreenView extends StatefulWidget {
  const ChatScreenView({super.key});

  @override
  State<ChatScreenView> createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView> {
  final controller = Get.put(ChatScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar(
        title: Text(
          'Chat',
        ),
        isLeading: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: controller.getChatHistory(
                adminId: controller.adminId.value,
                userId: Preference.userId ?? '',
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                var chats = snapshot.data!.docs;

                if (chats.isEmpty) {
                  controller.initialMessage(
                    adminId: controller.adminId.value,
                    userId: Preference.userId,
                  );
                  return Center(
                    child: Text(
                      "No chats available",
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: chats.length,
                  padding: EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    var message = chats[index].data() as Map<String, dynamic>;
                    bool isSender = message['senderId'] == Preference.userId;

                    return Align(
                      alignment: isSender
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isSender ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          message['message'] ?? '',
                          style: TextStyle(
                              color: isSender ? Colors.white : Colors.black),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Obx(
            () => Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.blackColor,
                  ),
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InputField(
                        controller: controller.messageController.value,
                        hintText: 'Type a message...',
                        textInputAction: TextInputAction.done,
                        validator: (value) {},
                        onChange: (value) {
                          controller.messageController.refresh();
                        },
                        minLine: 1,
                        maxLine: 3,
                        border: InputBorder.none,
                        disableBorder: InputBorder.none,
                        enableBorder: InputBorder.none,
                        focusBorder: InputBorder.none,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            openBottomSheet();
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                        Gap(5),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 5,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              controller.sendMessage(
                                adminId: controller.adminId.value,
                                message:
                                    controller.messageController.value.text,
                                userId: Preference.userId,
                              );
                            },
                            child: Icon(
                              Icons.send,
                              size: 25,
                              color: controller
                                      .messageController.value.text.isNotEmpty
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  openBottomSheet() {
    return showModalBottomSheet(
      context: Get.context!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.attach_file, color: Colors.blue),
                title: Text("Choose a File"),
                onTap: () {
                  Navigator.pop(context);
                  controller.pickDocument();
                },
              ),
              ListTile(
                leading: Icon(Icons.image, color: Colors.green),
                title: Text("Pick from Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  controller.pickImageFromGallery();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.red),
                title: Text("Take a Photo"),
                onTap: () {
                  Navigator.pop(context);
                  controller.takePhoto();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
