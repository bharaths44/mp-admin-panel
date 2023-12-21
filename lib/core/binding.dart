import 'package:adminpanel/core/dependency.dart';
import 'package:adminpanel/src/view/screens/add_product/add_product.dart';
import 'package:get/get.dart';

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: '/add_product/',
      page: () => AddProductScreen(),
      binding: AddProductControllerBinding(),
    ),
  ];
}
