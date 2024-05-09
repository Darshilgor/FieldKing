// import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';

// class SignupLoginController extends GetxController {
//   RxBool isSignup = false.obs;
//   Future checkIsSignup() async {
//     SignupLoginController controller = Get.put(SignupLoginController());
//     var directory = await getApplicationDocumentsDirectory();
//     Hive.init(directory.path);

//     var box = await Hive.openBox('Field King');

//     box.put('isSignup', false);
//     var value = box.get('isSignup');

//     if (value != null) {
//       controller.isSignup.value = value;
//     }
//     box.close();
//   }
// }

// import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';

// class SignupLoginController extends GetxController {
//   RxBool isSignup = false.obs;
//   Future checkIsSignup() async {
//     SignupLoginController controller = Get.put(SignupLoginController());
//     var directory = await getApplicationDocumentsDirectory();
//     Hive.init(directory.path);

//     var box = await Hive.openBox('Field King');

//     box.put('isSignup', false);
//     var value = box.get('isSignup');

//     if (value != null) {
//       controller.isSignup.value = value;
//     }
//     box.close();
//   }
// }

import 'package:get/get.dart';

class SignupLoginController extends GetxController {
  RxBool? isSignup;
}

