import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_project/controllers/product_controller.dart';
import 'package:my_flutter_project/models/product_model.dart';
import 'package:my_flutter_project/main.dart';
import 'package:my_flutter_project/product_detail_screen.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Products'),
        backgroundColor: '#EC93B7'.toColor(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by product name',
                border: OutlineInputBorder(),
              ),
              onChanged: (query) async {
                if (query.isNotEmpty) {
                  await productController.searchProducts(query);
                } else {
                  await productController.fetchData();
                }
              },
            ),
            SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (productController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (productController.products.isEmpty) {
                  return Center(child: Text('No products found'));
                } else {
                  return ListView.builder(
                    itemCount: productController.products.length,
                    itemBuilder: (context, index) {
                      final product = productController.products[index];
                      return ListTile(
                        title: Text(product.name ?? ''),
                        // subtitle: Text(product.description ?? ''),
                        onTap: () {
                          // Navigate to product detail screen
                          Get.to(() => ProductDetailPage(index: index));
                        },
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
