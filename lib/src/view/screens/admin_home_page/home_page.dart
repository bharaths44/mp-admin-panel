import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/customappbar.dart';
import 'home_page_controller.dart';

class HomePage extends StatelessWidget {
  final AdminPageController controller = Get.put(AdminPageController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Admin DashBoard',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            bigTitleCard(
                'Total Money Earned', controller.totalMoneyEarned, Icons.money),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  statsCard('Total Orders', controller.totalOrders,
                      Icons.shopping_cart),
                  statsCard('Total Users', controller.totalUsers, Icons.people),
                  statsCard('Most Ordered Product',
                      controller.mostOrderedProduct, Icons.shopping_basket),
                  statsCard('Average Order Value', controller.averageOrderValue,
                      Icons.receipt_long),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget statsCard(String title, dynamic value, IconData icon) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: Colors.grey),
            Obx(() => Text(
                  '$title: ${value.value}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}

Widget bigTitleCard(String title, dynamic value, IconData icon) {
  return Card(
    elevation: 5,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 50, color: Colors.grey),
          Obx(() => Text(
                '$title: ${value.value}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )),
        ],
      ),
    ),
  );
}
