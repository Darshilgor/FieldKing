import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/packages/app/module/chat/iamge_preview.dart';
import 'package:field_king/packages/app/module/chat/pdf_preview_screen.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/services/firebase_services/firebase_services.dart';
import 'package:field_king/services/google_services/google_services.dart';
import 'package:field_king/services/show_loader.dart';
import 'package:field_king/services/toast_message/toast_message.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
    String? userId,
    String? adminId,
  }) {
    return FirebaseFirestoreServices.getChatHistory(
      userId: userId ?? '',
      adminId: adminId ?? '',
    );
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

  // Future<void> pickDocument() async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       allowMultiple: true,
  //       type: FileType.custom,
  //       allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
  //     );

  //     if (result != null && result.files.isNotEmpty) {
  //       List<File> imageFiles = [];
  //       List<File> pdfFiles = [];

  //       for (var file in result.files) {
  //         if (file.path != null) {
  //           File selectedFile = File(file.path!);
  //           String ext = selectedFile.path.split('.').last.toLowerCase();

  //           if (['jpg', 'jpeg', 'png'].contains(ext)) {
  //             imageFiles.add(selectedFile);
  //           } else if (ext == 'pdf') {
  //             pdfFiles.add(selectedFile);
  //           }
  //         }
  //       }

  //       if (pdfFiles.isNotEmpty) {
  //         if (pdfFiles.length > 1) {
  //           pdfFiles = [pdfFiles.first];
  //           print("Only one PDF is allowed.");
  //         }

  //         Get.to(() => PdfPreviewScreen(
  //               pdfFile: pdfFiles.first,
  //               onSend: () async {
  //                 ShowLoader.showEasyLoader();
  //                 await sendPdfInChat(pdfFiles.first);
  //                 EasyLoading.dismiss();
  //                 Get.back();
  //               },
  //             ));
  //       }

  //       if (imageFiles.isNotEmpty) {
  //         Get.to(
  //           () => ImagePreviewScreen(
  //             imageFiles: imageFiles,
  //             onSend: () async {
  //               ShowLoader.showEasyLoader();
  //               await sendImagesInChat(imageFiles);
  //               EasyLoading.dismiss();
  //               Get.back();
  //             },
  //           ),
  //         );
  //       }
  //     } else {
  //       print("No file selected");
  //     }
  //   } catch (e) {
  //     print("Error picking document: $e");
  //   }
  // }

  Future<void> pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false, 
        type: FileType.custom,
        allowedExtensions: ['pdf'], 
      );

      if (result != null && result.files.isNotEmpty) {
        List<File> pdfFiles = [];

        for (var file in result.files) {
          if (file.path != null) {
            File selectedFile = File(file.path!);
            String ext = selectedFile.path.split('.').last.toLowerCase();

            // Check if the selected file is a PDF
            if (ext == 'pdf') {
              pdfFiles.add(selectedFile);
            }
          }
        }

        if (pdfFiles.isNotEmpty) {
          Get.to(() => PdfPreviewScreen(
                pdfFile: pdfFiles
                    .first, // Only the first PDF (since we allow only one)
                onSend: () async {
                  ShowLoader.showEasyLoader();
                  await sendPdfInChat(pdfFiles.first);
                  EasyLoading.dismiss();
                  Get.back();
                },
              ));
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
              ShowLoader.showEasyLoader();

              await sendImagesInChat(selectedImages);
              EasyLoading.dismiss();
              Get.back();
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

  // Future<void> takePhoto() async {
  //   try {
  //     String? userIds;

  //     userIds = await Preference.userId;

  //     String? docId = '${adminId.value}$userIds';

  //     final XFile? photo = await picker.pickImage(source: ImageSource.camera);

  //     if (photo != null) {
  //       File imageFile = File(photo.path);
  //       List<File> imageFileList = [];
  //       imageFileList.add(imageFile);
  //       List<String>? imageUrl =
  //           await GoogleDriveService.uploadMultipleImagesToDrive(imageFileList);

  //       if (imageUrl.isNotEmpty) {
  //         imageUrl.forEach(
  //           (url) async {
  //             await FirebaseFirestore.instance
  //                 .collection('Chats')
  //                 .doc(docId)
  //                 .collection('Messages')
  //                 .add(
  //               {
  //                 'isRead': false,
  //                 'senderId': userIds,
  //                 'receiverId': adminId.value,
  //                 'timestamp': DateTime.now(),
  //                 'messageType': 'image',
  //                 'message': '',
  //                 'mediaUrl': url,
  //               },
  //             );
  //           },
  //         );

  //         print("Chat message with images sent.");
  //       } else {
  //         print("No image URLs found.");
  //       }
  //     }
  //   } catch (e) {
  //     print("Error taking photo: $e");
  //   }
  // }
  Future<void> takePhoto() async {
    try {
      final userIds = await Preference.userId;
      final admin = adminId.value;

      if (userIds == null || admin.isEmpty) {
        print("User ID or Admin ID is null or empty. Cannot proceed.");
        return;
      }

      final docId = '$admin$userIds';
      final chatPath = 'Chat/$docId';

      final XFile? photo = await picker.pickImage(source: ImageSource.camera);

      ShowLoader.showEasyLoader();

      if (photo != null) {
        File imageFile = File(photo.path);

        final fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final extension = imageFile.path.split('.').last;
        final fullPath = '$chatPath/$fileName.$extension';

        final ref = FirebaseStorage.instance.ref().child(fullPath);

        final uploadTask = ref.putFile(
          imageFile,
          SettableMetadata(),
        );

        final snapshot = await uploadTask;
        final downloadUrl = await snapshot.ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('Chats')
            .doc(docId)
            .collection('Messages')
            .add({
          'isRead': false,
          'senderId': userIds,
          'receiverId': admin,
          'timestamp': DateTime.now(),
          'messageType': 'image',
          'message': '',
          'mediaUrl': downloadUrl,
        });

        print("✅ Chat message with image sent.");
      } else {
        print("No photo captured.");
      }
      EasyLoading.dismiss();
    } catch (e) {
      Get.back();
      print("❌ Error taking photo and uploading: $e");
    }
  }

//   Future<void> sendImagesInChat(List<File> images) async {
//     String? userIds;
//     List<String> uploadedUrls = [];

//     userIds = await Preference.userId;

//     String? docId = '${adminId.value}$userIds';
//     String chatFolderName = '${adminId.value}${Preference.userId}';
//     String chatPath = 'Chat/$chatFolderName';

//     /// upload image in google drive and get the urls.
//     // List<String> urls =
//     //     await GoogleDriveService.uploadMultipleImagesToDrive(images);

//    try{
//  for (File file in images) {
//       print('file is $file');
//       String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       String extension = file.path.split('.').last;
//       Reference storageRef = FirebaseStorage.instance
//           .ref()
//           .child('$chatPath/$docId/$fileName.$extension');

//       UploadTask uploadTask = storageRef.putFile(file);

//       try {
//         TaskSnapshot snapshot = await uploadTask;
//         String downloadUrl = await snapshot.ref.getDownloadURL();
//         print('downlaod url is $downloadUrl');

//         uploadedUrls.add(downloadUrl);
//       } catch (e) {
//         print("Error uploading file: $e");
//       }
//     }

//    }
//    catch(e)
//    {
//     print('main error is $e');
//    }

//     uploadedUrls.forEach(
//       (url) async {
//         await FirebaseFirestore.instance
//             .collection('Chats')
//             .doc(docId)
//             .collection('Messages')
//             .add(
//           {
//             'isRead': false,
//             'senderId': userIds,
//             'receiverId': adminId.value,
//             'timestamp': DateTime.now(),
//             'messageType': 'image',
//             'message': '',
//             'mediaUrl': url,
//           },
//         );
//       },
//     );

//     print("Chat message with images sent.");

//     Get.back();
//   }
  Future<void> sendImagesInChat(List<File> images) async {
    try {
      final userId = await Preference.userId;
      final admin = adminId.value;

      if (userId == null || admin.isEmpty) {
        print("User ID or Admin ID is null or empty. Cannot proceed.");
        return;
      }

      final docId = '$admin$userId';
      final chatFolderName = '$admin$userId';
      final chatPath = 'Chat/$chatFolderName';

      List<String> uploadedUrls = [];

      for (File file in images) {
        try {
          final fileName = DateTime.now().millisecondsSinceEpoch.toString();
          final extension = file.path.split('.').last;
          final fullPath = '$chatPath/$fileName.$extension';

          final ref = FirebaseStorage.instance.ref().child(fullPath);
          final uploadTask = ref.putFile(
            file,
            SettableMetadata(),
          );
          final snapshot = await uploadTask;
          final downloadUrl = await snapshot.ref.getDownloadURL();

          uploadedUrls.add(downloadUrl);
        } catch (e, stackTrace) {
          print("Error uploading file: $e");
        }
      }

      for (String url in uploadedUrls) {
        try {
          await FirebaseFirestore.instance
              .collection('Chats')
              .doc(docId)
              .collection('Messages')
              .add({
            'isRead': false,
            'senderId': userId,
            'receiverId': admin,
            'timestamp': DateTime.now(),
            'messageType': 'image',
            'message': '',
            'mediaUrl': url,
          });
        } catch (e) {
          print("Error writing to Firestore: $e");
        }
      }
      print("✅ Chat message with images sent.");
    } catch (e) {
      Get.back();
      print('❌ Main error: $e');
    }
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

  Future<void> sendPdfInChat(File pdfFile) async {
    try {
      final userId = await Preference.userId;
      final admin = adminId.value;

      if (userId == null || admin.isEmpty) {
        print("User ID or Admin ID is null or empty. Cannot proceed.");
        return;
      }

      final docId = '$admin$userId';
      final chatFolderName = '$admin$userId';
      final chatPath = 'Chat/$chatFolderName';

      // Upload PDF to Firebase Storage
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final extension = pdfFile.path.split('.').last;
      final fullPath = '$chatPath/$fileName.$extension';

      final ref = FirebaseStorage.instance.ref().child(fullPath);
      final uploadTask = ref.putFile(
        pdfFile,
        SettableMetadata(contentType: 'application/pdf'),
      );
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Send PDF URL to Firestore
      await FirebaseFirestore.instance
          .collection('Chats')
          .doc(docId)
          .collection('Messages')
          .add(
        {
          'isRead': false,
          'senderId': userId,
          'receiverId': admin,
          'timestamp': DateTime.now(),
          'messageType': 'pdf',
          'message': '',
          'mediaUrl': downloadUrl,
        },
      );

      print("✅ Chat message with PDF sent.");
    } catch (e) {
      print('❌ Error sending PDF: $e');
    }
  }
}
