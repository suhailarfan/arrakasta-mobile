import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_project/controllers/login_controller.dart';
import 'package:my_flutter_project/controllers/profile_controller.dart';
import 'package:my_flutter_project/controllers/register_controller.dart';
import 'package:my_flutter_project/controllers/coin_controller.dart';
import 'package:my_flutter_project/home_screen.dart';
import 'package:my_flutter_project/welcome_screen.dart';
import 'package:my_flutter_project/product_screen.dart';
import 'package:my_flutter_project/controllers/initial_screen_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: '#fee8fc'.toColor(),
        fontFamily: 'Rag',
      ),
      home: FutureBuilder<Widget>(
        future: _initializeControllersAndDetermineInitialScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Show loading indicator while determining initial screen
          }
          if (snapshot.hasError) {
            // Handle error here
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return snapshot.data ?? Container(); // Return initial screen or empty container if snapshot data is null
        },
      ),
    );
  }

  Future<Widget> _initializeControllersAndDetermineInitialScreen() async {
    // Initialize all necessary controllers
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => RegisterationController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => CoinController());
    Get.lazyPut(() => InitialScreenController()); // Register InitialScreenController

    // Get instance of InitialScreenController
    final initialScreenController = Get.find<InitialScreenController>();

    // Determine the initial screen
    final initialScreen = await initialScreenController.determineInitialScreen();

    return initialScreen;
  }
}

extension ColorExtension on String {
  Color toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return Colors.white; // Default color if string is invalid
  }
}

// Example logout function
void logout() {
  // Clear any necessary data or perform any required logout operations
  Get.delete<LoginController>(); // Ensure the LoginController is deleted
  Get.delete<ProfileController>(); // Ensure the ProfileController is deleted
  Get.delete<CoinController>(); // Ensure the CoinController is deleted
  Get.delete<InitialScreenController>(); // Ensure the InitialScreenController is deleted

  // Navigate to MyApp to reinitialize the application
  Get.offAll(() => MyApp());
}
