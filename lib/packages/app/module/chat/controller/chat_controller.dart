import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/packages/app/model/user_chat_model.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/services/firebase_services/firebase_services.dart';

class ChatController extends GetxController {
  RxList<UserChatModel> user = <UserChatModel>[].obs;

  @override
  void onInit() {
    fetchAdmin();

    super.onInit();
  }

  fetchAdmin() async {
    List<UserChatModel> admins = await FirebaseFirestoreServices.getAdminList();
    user.assignAll(admins);
  }
}
