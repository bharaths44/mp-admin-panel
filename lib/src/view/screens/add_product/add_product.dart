import 'package:ssp_admin_panel/src/view/screens/add_product/add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/appdata.dart';

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
            DropdownButtonFormField(
              value: controller.type.value,
              decoration: const InputDecoration(labelText: 'Product Type'),
              items: AppData.categories.map((String category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (newValue) {
                controller.type.value = newValue.toString() as TextEditingValue;
              },
            ),
            Obx(() {
              return controller.image.value != null
                  ? Image.file(
                      controller.image.value!,
                      width: 250,
                      height: 250,
                      fit: BoxFit.contain,
                    )
                  : Container();
            }),
            Obx(() {
              return ElevatedButton(
                onPressed:
                    controller.loading.value ? null : controller.uploadImage,
                child: controller.loading.value
                    ? const CircularProgressIndicator()
                    : const Text('Upload Image'),
              );
            }),
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
