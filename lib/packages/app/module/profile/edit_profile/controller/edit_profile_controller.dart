import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/packages/app/module/profile/view_profile/controller/view_profile_controller.dart';
import 'package:field_king/packages/config.dart';
import 'package:field_king/services/firebase_services/firebase_services.dart';
import 'package:field_king/services/google_services/google_services.dart';
import 'package:field_king/services/toast_message/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<void> updateProfile() async {
    final GoogleDriveService googleDriveService = GoogleDriveService();

    if (profileImage.value == null) {
      print("No image selected.");
      return;
    }

    String? newImageUrl =
        await googleDriveService.uploadProfileImage(profileImage.value!);
    if (newImageUrl != null) {
      FirebaseFirestoreServices.updateProfile(
        brandName: brandNameController.value.text.trim(),
        firstName: firstNameController.value.text.trim(),
        lastName: lastNameController.value.text.trim(),
        phoneNumber: phoneNumberController.value.text.trim(),
        profileImage: newImageUrl,
      ).then(
        (value) {
          Get.find<ViewProfileController>().updateProfileImage();
          Get.back();
        },
      );
    } else {
      ToastMessage.getSnackToast(
        message: 'Something went wrong to upload image.',
      );
    }
  }
}
