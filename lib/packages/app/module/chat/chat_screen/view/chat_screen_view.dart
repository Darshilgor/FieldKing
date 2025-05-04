import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/components/unfocus_keyboard.dart';
import 'package:field_king/packages/app/module/chat/chat_screen/controller/chat_screen_controller.dart';
import 'package:field_king/packages/app/module/chat/image_gallery_view.dart';
import 'package:field_king/packages/app/module/chat/pdf_viewer/pdf_viewer.dart';
import 'package:field_king/packages/app/module/chat/pdf_viewer/pdf_viewer_screen.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/packages/routes/app_pages.dart';
import 'package:field_king/services/app_bar.dart';
import 'package:field_king/services/app_color/app_colors.dart';
import 'package:field_king/services/common_code/common_code.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreenView extends StatefulWidget {
  const ChatScreenView({super.key});

  @override
  State<ChatScreenView> createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView>
    with WidgetsBindingObserver {
  final controller = Get.put(ChatScreenController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller.scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    if (bottomInset > 0.0) {
      controller.scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
                  controller.scrollToBottom();

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
                  if (snapshot.hasData) {
                    return StreamBuilder<Object>(
                        stream: controller.getUserStatus(),
                        builder: (context, userTyping) {
                          return ListView.builder(
                            itemCount: chats.length,
                            controller: controller.scrollController,
                            padding: EdgeInsets.all(10),
                            itemBuilder: (context, index) {
                              var chat =
                                  chats[index].data() as Map<String, dynamic>;
                              bool isSender =
                                  chat['senderId'] == Preference.userId;

                              return Align(
                                alignment: isSender
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  padding: chat['messageType'] == 'text'
                                      ? EdgeInsets.all(10)
                                      : EdgeInsets.all(0),
                                  decoration: chat['messageType'] == 'text'
                                      ? BoxDecoration(
                                          color: isSender
                                              ? Colors.blue
                                              : Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )
                                      : BoxDecoration(
                                          border: Border.all(
                                            color: Colors.blue,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                  child: chat['messageType'] == 'text'
                                      ? Text(
                                          chat['message'] ?? '',
                                          style: TextStyle(
                                              color: isSender
                                                  ? Colors.white
                                                  : Colors.black),
                                        )
                                      : chat['messageType'] == 'image'
                                          ? GestureDetector(
                                              onTap: () {
                                                closeKeyboard();
                                                final imageMessages = chats
                                                    .where((e) =>
                                                        (e.data() as Map<String,
                                                                dynamic>)[
                                                            'messageType'] ==
                                                        'image')
                                                    .toList();

                                                final currentImageIndex =
                                                    imageMessages.indexWhere(
                                                  (e) =>
                                                      (e.data() as Map<String,
                                                              dynamic>)[
                                                          'mediaUrl'] ==
                                                      chat['mediaUrl'],
                                                );

                                                Get.to(
                                                  () => ImageGalleryView(
                                                    imageUrls: imageMessages
                                                        .map((e) => (e.data()
                                                                as Map<String,
                                                                    dynamic>)[
                                                            'mediaUrl'] as String)
                                                        .toList(),
                                                    initialIndex:
                                                        currentImageIndex,
                                                  ),
                                                );
                                              },
                                              child: extendedImage(
                                                imageUrl: chat['mediaUrl'],
                                                height: Get.height * 0.2,
                                                width: Get.width * 0.7,
                                                fit: BoxFit.fitWidth,
                                                boxShap: BoxShape.rectangle,
                                                catchHeight: 2000,
                                                catchWidth: 2000,
                                                circularProcessPadding:
                                                    EdgeInsets.all(
                                                  100,
                                                ),
                                                BorderRadius:
                                                    BorderRadius.circular(
                                                  10,
                                                ),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                // Open PDF Viewer
                                                closeKeyboard();
                                                Get.to(
                                                  () => PdfViewerScreen(
                                                    pdfUrl: chat['mediaUrl'],
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                height: 100,
                                                width: 200,
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.red,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.picture_as_pdf,
                                                        color: Colors.red,
                                                        size: 40),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: Text(
                                                        "View PDF",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                ),
                              );
                            },
                          );
                        });
                  }
                  return Container();
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
                            controller.updateTypingStatus(value: value);
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
                                controller.scrollToBottom();
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
                  Get.back();
                  controller.pickDocument();
                },
              ),
              ListTile(
                leading: Icon(Icons.image, color: Colors.green),
                title: Text("Pick from Gallery"),
                onTap: () {
                  Get.back();
                  controller.pickImageFromGallery();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.red),
                title: Text("Take a Photo"),
                onTap: () {
                  Get.back();
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
