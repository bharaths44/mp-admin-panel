import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssp_admin_panel/src/view/screens/all_product_screen/all_product_controller.dart';
import '../../../model/product.dart';

class AllProductScreen extends StatelessWidget {
  final AllProductsController allProductsController =
      Get.put(AllProductsController());

  AllProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: Obx(() {
        if (allProductsController.products.isEmpty) {
          allProductsController.getProducts();
          return const Center(child: CircularProgressIndicator());
        } else {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: allProductsController.products.length,
            itemBuilder: (context, index) {
              Product product = allProductsController.products[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed('/productDetailScreen',
                      arguments: allProductsController.products[index]);
                  print('Product tapped: ${product.name}');
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: GridTile(
                    footer: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        color: Colors.black54,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Name: ${product.name}\nStock: ${product.stock}\nPrice: ${product.price}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        product.image,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
