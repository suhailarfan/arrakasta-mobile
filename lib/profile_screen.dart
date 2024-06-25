import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_project/controllers/login_controller.dart';
import 'package:my_flutter_project/main.dart';
import 'package:my_flutter_project/product_screen.dart';
import 'package:http/http.dart' as http;
import 'package:my_flutter_project/home_screen.dart';
import 'package:my_flutter_project/controllers/profile_controller.dart';
import 'package:my_flutter_project/controllers/coin_controller.dart';
import 'package:my_flutter_project/search_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(GetMaterialApp(home: ProfileScreen()));
}

class ProfileScreen extends StatelessWidget {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final LoginController loginController = Get.find<LoginController>();
  final ProfileController profileController = Get.find<ProfileController>(); 
  final CoinController coinController = Get.find<CoinController>();

  Future<void> logout() async {
    try {
      final SharedPreferences prefs = await _prefs;
      final response = await http.post(
        Uri.parse('http://203.175.11.204/api/v1/logout'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${loginController.token}',
        },
      );

      if (response.statusCode == 200) {
        // Get.delete<LoginController>();
        // Get.delete<CoinController>();
        Get.delete<ProfileController>();
        // Get.delete<InitialScreenController>();

        // Get.deleteAll();
        await prefs.clear();
        Get.offAll(() => HomeScreen());
      } else if (response.statusCode == 302) {
        // Redirect response, handle it by following the redirection
        final redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          // Perform another request to the redirection URL
          final redirectResponse = await http.get(Uri.parse(redirectUrl));
          if (redirectResponse.statusCode == 200) {
            // Successful redirection, handle it as needed
          } else {
            // Handle redirection failure
            print('Redirection failed: ${redirectResponse.body}');
          }
        } else {
          // No redirection URL found in the response headers
          print('Redirection URL not found');
        }
      } else {
        // Handle logout failure
        print('Logout failed: ${response.body}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error during logout: $e');
    }
  }

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
                Get.to(() => ProductScreen());
                break;
              case 1:
                Get.to(() => SearchScreen());
                break;
              case 2:
                // current screen
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
      body: Obx(() {
        if (profileController.isLoading.isTrue) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              _buildProfileItem(
                  'Name', profileController.profileData?.name ?? ''),
              _buildProfileItem(
                  'Email', profileController.profileData?.email ?? ''),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: logout,
                child: Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: '#B8257C'.toColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ), 
              ),
            ],
          );
        }
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed functionality here
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
}
