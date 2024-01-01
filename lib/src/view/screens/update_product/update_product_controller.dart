import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ssp_admin_panel/src/view/screens/all_product_screen/all_product_controller.dart';

import '../../../model/product.dart';

class UpdateProductController extends GetxController {
  final AllProductsController allProductsController =
      Get.find<AllProductsController>();
  TextEditingController about = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController type = TextEditingController();
  FirebaseStorage storage = FirebaseStorage.instance;

  var inputImageUrl = ''.obs;
  var loading = false.obs;
  var image = Rx<File?>(null);

  UpdateProductController(Product product) {
    about = TextEditingController(text: product.about);
    stock = TextEditingController(text: product.stock.toString());
    name = TextEditingController(text: product.name);
    price = TextEditingController(text: product.price.toString());
    type = TextEditingController(text: product.type);
    inputImageUrl.value = product.image;
  }
  Future<void> uploadImage() async {
    final picker = ImagePicker();
    loading.value = true;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('product_images/${name.text.toString()}');
      final uploadTask = storageRef.putFile(image.value!);

      await uploadTask.whenComplete(() async {
        final downloadURL = await storageRef.getDownloadURL();
        inputImageUrl.value = downloadURL;
        loading.value = false;
        update();
      });
    } else {
      print('No image selected');
      // No need to return here, as it's optional to have an image
    }
  }

  Future<void> updateProduct() async {
    loading.value = true;
    final product = {
      'about': about.text.toString(),
      'stock': int.parse(stock.text.toString()),
      'name': name.text.toString(),
      'price': int.parse(price.text.toString()),
      'type': type.text.toString(),
      'image': inputImageUrl.value,
      'isAvailable': true,
    };
    await FirebaseFirestore.instance
        .collection('product')
        .doc(name.text.toString())
        .set(product);
    loading.value = false;
    Get.snackbar(
      duration: const Duration(seconds: 2),
      'Success:',
      'Product Updated successfully',
      backgroundColor: Colors.green,
    );
    allProductsController.clearproducts();
    allProductsController.getProducts();
    allProductsController.update();
   
  }
}
