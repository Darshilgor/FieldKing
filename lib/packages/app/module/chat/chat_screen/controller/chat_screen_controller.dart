import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/packages/app/module/chat/iamge_preview.dart';
import 'package:field_king/packages/app/module/chat/pdf_preview_screen.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/services/firebase_services/firebase_services.dart';
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
          Get.to(() => PdfPreviewScreen(
                fileName: pdf.toString(),
                onSend: () {
                  print('Send PDF: ${pdf.path}');
                },
              ));
        }

        if (imageFiles.isNotEmpty) {
          Get.to(() => ImagePreviewScreen(
                imageFiles: imageFiles,
                onSend: () {},
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
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File file = File(image.path);
    }
  }

  Future<void> takePhoto() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      File file = File(photo.path);
    }
  }
}
