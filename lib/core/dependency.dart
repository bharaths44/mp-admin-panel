import 'package:get/get.dart';

import '../src/view/screens/add_product/add_product_controller.dart';

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
