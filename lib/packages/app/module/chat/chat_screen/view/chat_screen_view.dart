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
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.blackColor,
                ),
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.messageController.value,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(10),
                        // ),
                        
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.blue),
                    onPressed: () {
                      controller.sendMessage(
                        adminId: controller.adminId.value,
                        message: controller.messageController.value.text,
                        userId: Preference.userId,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
