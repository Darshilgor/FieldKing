import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/services/firebase_services/firebase_services.dart';

class ChatScreenController extends GetxController {
  RxString adminId = RxString('');
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
    FirebaseFirestoreServices.sendMessage(
      adminId: adminId,
      userId: userId,
      message: message,
      messageType: 'text',
      senderIsAdmin: false,
    );
  }
}
