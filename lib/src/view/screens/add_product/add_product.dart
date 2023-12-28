import 'package:ssp_admin_panel/src/view/screens/add_product/add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductScreen extends StatelessWidget {
  final AddProductController controller = Get.put(AddProductController());

  AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: controller.name,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: controller.about,
              decoration: const InputDecoration(labelText: 'About Product'),
            ),
            TextField(
              controller: controller.price,
              decoration: const InputDecoration(labelText: 'Product Price'),
            ),
            TextField(
              controller: controller.stock,
              decoration: const InputDecoration(labelText: 'Product Stock'),
            ),
            TextField(
              controller: controller.type,
              decoration: const InputDecoration(labelText: 'Product Type'),
            ),
            if (controller.image != null) Image.file(controller.image!),
            ElevatedButton(
              onPressed: controller.uploadImage,
              child: const Text('Upload Image'),
            ),
            ElevatedButton(
              onPressed: () {
                controller.addProduct();
              },
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
