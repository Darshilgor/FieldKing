import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/packages/app/module/chat/iamge_preview.dart';
import 'package:field_king/packages/app/module/chat/pdf_preview_screen.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/services/firebase_services/firebase_services.dart';
import 'package:field_king/services/google_services/google_services.dart';
import 'package:field_king/services/toast_message/toast_message.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreenController extends GetxController {
  RxString adminId = RxString('');
  final ImagePicker picker = ImagePicker();
  String? fileType;
  String? fileName;
  File? selectedFile;
  List<File>? imageFiles;
  Rx<TextEditingController> messageController = TextEditingController().obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  Stream<QuerySnapshot> getChatHistory({
    required String userId,
    required String adminId,
  }) {
    return FirebaseFirestoreServices.getChatHistory(
        userId: userId, adminId: adminId);
  }

  getArgument() {
    var argument = Get.arguments;

    if (argument != null) {
      adminId.value = argument['adminId'];
    }
  }

  initialMessage({String? adminId, String? userId, String? message}) async {
    await FirebaseFirestoreServices.addChatWelcomeMessage(
      adminId: adminId,
      userId: userId,
    );
  }

  sendMessage({
    String? adminId,
    String? userId,
    String? message,
  }) {
    messageController.value.clear();
    messageController.refresh();
    FirebaseFirestoreServices.sendMessage(
      adminId: adminId,
      userId: userId,
      message: message,
      messageType: 'text',
      senderIsAdmin: false,
    );
  }

  Future<void> pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );

      if (result != null && result.files.isNotEmpty) {
        List<File> imageFiles = [];
        List<File> pdfFiles = [];

        for (var file in result.files) {
          if (file.path != null) {
            File selectedFile = File(file.path!);
            String ext = selectedFile.path.split('.').last.toLowerCase();

            if (['jpg', 'jpeg', 'png'].contains(ext)) {
              imageFiles.add(selectedFile);
            } else if (ext == 'pdf') {
              pdfFiles.add(selectedFile);
            }
          }
        }

        for (var pdf in pdfFiles) {
          Get.to(
            () => PdfPreviewScreen(
              fileName: pdf.toString(),
              onSend: () {},
            ),
          );
        }

        if (imageFiles.isNotEmpty) {
          Get.to(
            () => ImagePreviewScreen(
              imageFiles: imageFiles,
              onSend: () async {
                await sendImagesInChat(imageFiles);
              },
            ),
          );
        }
      } else {
        print("No file selected");
      }
    } catch (e) {
      print("Error picking document: $e");
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
      );

      if (result != null && result.files.isNotEmpty) {
        List<File> selectedImages = result.files
            .where((file) => file.path != null)
            .map((file) => File(file.path!))
            .toList();

        Get.to(
          () => ImagePreviewScreen(
            imageFiles: selectedImages,
            onSend: () async {
              await sendImagesInChat(selectedImages);
            },
          ),
        );
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking images: $e");
    }
  }

  Future<void> takePhoto() async {
    try {
      String? userIds;

      userIds = await Preference.userId;

      String? docId = '${adminId.value}$userIds';

      final XFile? photo = await picker.pickImage(source: ImageSource.camera);

      if (photo != null) {
        File imageFile = File(photo.path);
        List<File> imageFileList = [];
        imageFileList.add(imageFile);
        List<String>? imageUrl =
            await GoogleDriveService.uploadMultipleImagesToDrive(imageFileList);

        if (imageUrl.isNotEmpty) {
          imageUrl.forEach(
            (url) async {
              await FirebaseFirestore.instance
                  .collection('Chats')
                  .doc(docId)
                  .collection('Messages')
                  .add(
                {
                  'isRead': false,
                  'senderId': userIds,
                  'receiverId': adminId.value,
                  'timestamp': DateTime.now(),
                  'messageType': 'image',
                  'message': '',
                  'mediaUrl': url,
                },
              );
            },
          );

          print("Chat message with images sent.");
        } else {
          print("No image URLs found.");
        }
      }
    } catch (e) {
      print("Error taking photo: $e");
    }
  }

  Future<void> sendImagesInChat(List<File> images) async {
    String? userIds;

    userIds = await Preference.userId;

    String? docId = '${adminId.value}$userIds';

    List<String> urls =
        await GoogleDriveService.uploadMultipleImagesToDrive(images);

    if (urls.isNotEmpty) {
      urls.forEach(
        (url) async {
          await FirebaseFirestore.instance
              .collection('Chats')
              .doc(docId)
              .collection('Messages')
              .add(
            {
              'isRead': false,
              'senderId': userIds,
              'receiverId': adminId.value,
              'timestamp': DateTime.now(),
              'messageType': 'image',
              'message': '',
              'mediaUrl': url,
            },
          );
        },
      );

      print("Chat message with images sent.");
    } else {
      print("No image URLs found.");
    }
    Get.back();
  }

  scrollToBottom() {
    Future.delayed(
      Duration(milliseconds: 100),
      () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      },
    );
  }
}
