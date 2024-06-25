import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_project/controllers/product_controller.dart';
import 'package:my_flutter_project/models/product_model.dart';
import 'package:my_flutter_project/main.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  final int index;

  ProductDetailPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = productController.productData?.data?[index];
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: '#fee8fc'.toColor(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              // Image
              Container(
                height: 300,
                child: Image.network(
                  productController.host + 'storage/' + product!.image!, // Replace with your image URL
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              // Product Details
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    Text(
                      product?.name ?? '',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    // Price
                    Text(
                      'Rp ${product!.price}',
                      style: TextStyle(fontSize: 24, color: Colors.red),
                    ),
                    SizedBox(height: 8),
                    // Rating
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow),
                        SizedBox(width: 4),
                        Text(
                          product?.reviewsAvgRating.toString() ?? '',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                      'Deskripsi',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    // Price
                    Text(
                      product?.description.toString() ?? '',
                      style: TextStyle(fontSize: 16),
                    ),
                      ],
                    ),
                    SizedBox(height: 20),
              // Button to visit website
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide.none,
                        ),
                        backgroundColor: '#B8257C'.toColor(),
                                        ),
                        onPressed: () {
                        // Replace $productId with the actual product ID
                        int productId = product!.id ?? 0;
                        String url = 'http://203.175.11.204/products/$productId/show';
                        launchUrl(Uri.parse(url)); // Use url_launcher package to open URL
                                        },
                                        child: Text('Visit Website',
                                        style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                      ),
                    ),
                  ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
