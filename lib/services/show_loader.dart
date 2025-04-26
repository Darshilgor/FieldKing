import 'package:field_king/packages/config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ShowLoader
{


  static void showEasyLoader() {
    EasyLoading.instance
      ..displayDuration = const Duration(seconds: 3)
      ..indicatorType = EasyLoadingIndicatorType.threeBounce
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 50.0
      ..radius = 10.0
      ..progressColor = Colors.transparent
      ..backgroundColor = Colors.transparent
      ..boxShadow = <BoxShadow>[]
      ..indicatorColor = AppColor.blackColor
      ..textColor = Colors.white
      ..textStyle = const TextStyle(fontSize: 22, fontStyle: FontStyle.italic)
      ..maskColor = Colors.grey.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false
      ..maskType = EasyLoadingMaskType.custom;

    EasyLoading.show();
  }

}