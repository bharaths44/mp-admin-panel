import 'package:get/get.dart';

import '../src/view/screens/all_product_screen/all_product_controller.dart';

class AllProductsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllProductsController>(() => AllProductsController(),
        fenix: true);
  }
}

class DependencyCreator {
  static init() {
    AllProductsControllerBinding().dependencies();
  }
}
