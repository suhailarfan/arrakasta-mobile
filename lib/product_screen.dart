import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_project/chat_screen.dart';
import 'package:my_flutter_project/controllers/product_controller.dart';
import 'package:my_flutter_project/controllers/profile_controller.dart';
import 'package:my_flutter_project/main.dart';
import 'package:my_flutter_project/product_detail_screen.dart';
import 'package:my_flutter_project/profile_screen.dart';
import 'package:my_flutter_project/controllers/coin_controller.dart';
import 'package:my_flutter_project/search_screen.dart';

void main() {
  runApp(GetMaterialApp(home: ProductScreen()));
}

class ProductScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  final ProfileController profileController = Get.put(ProfileController());
  final CoinController coinController = Get.find<CoinController>(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Arrakasta'),
        automaticallyImplyLeading: false,
        backgroundColor: '#EC93B7'.toColor(),
        actions: [
          Row(
            children: [
              Icon(Icons.currency_exchange_outlined), // Coin icon
              SizedBox(width: 5), // Adjust spacing between icon and text
              _buildProfileItem(
                  '', coinController.coinModel.value.total.toString() ?? ''),
              SizedBox(width: 10), // Adjust spacing between icon and text
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: '#EC93B7'.toColor(), // Background color of the navigation bar
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), // Top left corner rounded
            topRight: Radius.circular(20), // Top right corner rounded
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 4, // Blur radius
              offset: Offset(0, -2), // Shadow offset
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: '#B8257C'.toColor(),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          onTap: (int index) {
            switch (index) {
              case 0:

                break;
              case 1:
                Get.to(() => SearchScreen());
                break;
              case 2:
                Get.to(() => ProfileScreen());
                break;
            }
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Cari',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            color: '#fee8fc'.toColor(), // Background color of the banner
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/img/bannerpage.png', // Change to your banner image path
                  width: double.infinity, // Make the banner image fill the width
                  fit: BoxFit.cover, // Adjust the fit of the image
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Check out our new product!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w100,
                      color: '#B8257C'.toColor(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 60),
              child: Obx(
                () => productController.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: (productController.productData?.data?.length ?? 0) ~/ 2,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                _buildProductItem(context, index * 2),
                                SizedBox(width: 8),
                                _buildProductItem(context, index * 2 + 1),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => ChatScreen());
        },
        label: DefaultTextStyle(
  style: TextStyle(color: Colors.white),
  child: Text('Butuh Bantuan?'),
),
        icon: Icon(Icons.chat, color: Colors.white,),
        backgroundColor: '#B8257C'.toColor(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildProductItem(BuildContext context, int index) {
    final product = productController.productData?.data?[index];
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(index: index),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150,
                    child: Center(
                      child: product?.image == null
                          ? Icon(Icons.image)
                          : Image.network(
                              productController.host + 'storage/' + product!.image!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    product?.name ?? '',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Rp ${product!.price}',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      SizedBox(width: 4),
                      Text(
                        product.reviewsAvgRating.toString() ?? '',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(width: 8),
                      Text(
                        product.reviewsAvgRating.toString() ?? '',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildProfileItemCoin(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 16),
      ],
    );
  }

    Widget _buildProfileItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
