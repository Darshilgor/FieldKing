import 'dart:io';

import 'package:field_king/packages/config.dart';
import 'package:field_king/services/firebase_services/firebase_services.dart';

class EditProfileController extends GetxController {
  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> brandNameController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<File?> profileImage = Rx<File?>(null);
  RxBool isButtonLoading = RxBool(false);
  RxString profilePhoto = RxString('');

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  getUserData() {
    firstNameController.value.text = Preference.firstName ?? '';
    lastNameController.value.text = Preference.lastName ?? '';
    brandNameController.value.text = Preference.brandName ?? '';
    phoneNumberController.value.text = Preference.phoneNumber ?? '';
    profilePhoto.value = Preference.profileImage ?? '';
  }

  updateProfileApiCall() {
    
    FirebaseFirestoreServices.updateProfile();
  }
}
