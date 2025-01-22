import 'package:field_king/packages/app/module/home_screen/controller/home_screen_controller.dart';
import 'package:field_king/packages/config.dart';

class HomeScreenView extends StatelessWidget {
  HomeScreenView({super.key});

  final controller = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
