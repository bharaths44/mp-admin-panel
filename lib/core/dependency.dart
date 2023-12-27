import 'package:get/get.dart';

import '../src/controller/add_product_controller.dart';

class AddProductControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddProductController>(() => AddProductController());
  }
}

class DependencyCreator {
  static init() {
    AddProductControllerBinding().dependencies();
  }
}
