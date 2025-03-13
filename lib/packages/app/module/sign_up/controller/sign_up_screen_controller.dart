import 'package:field_king/packages/config.dart';
import 'package:field_king/packages/routes/app_pages.dart';
import 'package:field_king/services/firebase_services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreenController extends GetxController {
  Rx<TextEditingController> phoneNoController = TextEditingController().obs;
  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> brandNameController = TextEditingController().obs;
  Rx<TextEditingController> locationController = TextEditingController().obs;
  RxBool isSubmitBtnLoading = RxBool(false);
  final signUpFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  getArgument() {
    var argument = Get.arguments;
    if (argument != null) {
      phoneNoController = argument['phoneNo'];
    } else {
      phoneNoController.value.text = Preference.phoneNumber ?? '';
    }
  }

  addUser() {
    FirebaseFirestoreServices.addUserDetails(
      brandName: brandNameController.value.text.trim(),
      firstName: firstNameController.value.text.trim(),
      lastName: lastNameController.value.text.trim(),
      phoneNumber: phoneNoController.value.text.trim(),
      address: locationController.value.text.trim(),
    ).then(
      (value) {
        Preference.brandName = brandNameController.value.text.trim();
        Preference.firstName = firstNameController.value.text.trim();
        Preference.lastName = lastNameController.value.text.trim();
        Preference.phoneNumber = phoneNoController.value.text.trim();
        Preference.address = locationController.value.text.trim();

        /// admin and user are in same app.
        // Preference.userType = (phoneNoController.value.text == '9409529203' ||
        //         phoneNoController.value.text == '9426781202')
        //     ? 'Admin'
        //     : 'User';

        Preference.userType = 'User';
        Preference.isLogin = true;
        isSubmitBtnLoading.value = false;
        Get.offAllNamed(
          Routes.tabBarScreen,
        );
      },
    );
  }
}
