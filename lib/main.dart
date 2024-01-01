import 'package:get/get.dart';
import 'package:ssp_admin_panel/core/dependency.dart';
import 'package:ssp_admin_panel/src/view/screens/add_product/add_product.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ssp_admin_panel/firebase_options.dart';
import 'package:ssp_admin_panel/src/view/screens/all_product_screen/product_detail_screen.dart';

import 'src/view/screens/all_product_screen/all_products.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyCreator.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      routes: {
        '/productDetailScreen': (context) => ProductDetailScreen(),
        '/allProductScreen': (context) => AllProductScreen(),
      },
      home: AllProductScreen(),
    );
  }
}
