
import 'package:adminpanel/src/controller/add_product_controller.dart';
import 'package:get/get.dart';



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
