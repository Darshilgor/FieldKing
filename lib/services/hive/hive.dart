// import 'package:field_king/controller/signup_login_controller.dart';
// import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:hive/hive.dart';

// class HiveClass {
//   var box;

//   Future intializeHive() async {
//     var directory = await getApplicationDocumentsDirectory();
//     Hive.init(directory.path);

//     box = await Hive.openBox('Field King');
//   }

//   updateSignupHive() {
//     box.put('isSignup', null);
//   }

//   getSignupHive() {
//     var value;
//     SignupLoginController signupLoginController =
//         Get.put(SignupLoginController());
//     try {
//       value = box.get('isSignup') == null ? false : true;
//     } catch (e) {}
//     print('value is $value');
//     if (value != null) {
//       signupLoginController.isSignup?.value = value;
//     }
//     return value;
//   }
// }
