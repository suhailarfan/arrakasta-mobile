// initial_screen_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_project/controllers/login_controller.dart';
import 'package:my_flutter_project/controllers/coin_controller.dart';
import 'package:my_flutter_project/home_screen.dart';
import 'package:my_flutter_project/welcome_screen.dart';
import 'package:my_flutter_project/product_screen.dart';

class InitialScreenController extends GetxController {
  final loginController = Get.find<LoginController>();
  final coinController = Get.find<CoinController>();
  
  Future<Widget> determineInitialScreen() async {
    await loginController.loadToken();

    if (!loginController.isLoggedIn.value) {
      return HomeScreen();
    } else {
      await coinController.fetchCoinData();

      if (coinController.coinModel.value.isCollected) {
        return ProductScreen();
      } else {
        return WelcomeScreen();
      }
    }
  }
}
