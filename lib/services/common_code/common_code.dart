import 'package:field_king/packages/config.dart';

Widget customContainer({
  String? title,
  double? width,
  Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width ?? Get.width,
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Center(
        child: Text(
          title ?? '',
          style: TextStyle().medium16.textColor(
                AppColor.blackColor,
              ),
        ),
      ),
    ),
  );
}
