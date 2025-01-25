import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king/packages/app/model/get_product_model.dart';
import 'package:field_king/packages/app/module/home_screen/controller/home_screen_controller.dart';
import 'package:field_king/packages/config.dart';

class HomeScreenView extends StatelessWidget {
  HomeScreenView({super.key});

  final controller = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Product>>(
        future: controller.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.hasData) {
            List<Product> products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];
                return ListTile(
                  title: Text(
                    // product.cables.entries.map((entry) {
                    //   return entry.value.cableType.entries
                    //       .map((subEntry) =>
                    //           subEntry.value.name)
                    //       ;
                    // }).join('\n'),
                    (product.cables[0] ?? Cable()).cableType?[0]?.name ?? '',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(product.cables.keys.join(', ')),
                );
              },
            );
          }

          return Text('No products found');
        },
      ),
    );
  }
}
