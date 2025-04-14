import 'package:field_king/packages/config.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TabbarController extends GetxController {
  RxInt currentIndex = RxInt(0);
   final GlobalKey<ScaffoldState> tabBarKey = GlobalKey<ScaffoldState>();

}
