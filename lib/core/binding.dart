
import 'package:get/get.dart';

import '../src/view/screens/add_product/add_product.dart';
import 'dependency.dart';

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: '/add_product/',
      page: () => AddProductScreen(),
      binding: AddProductControllerBinding(),
    ),
  ];
}
