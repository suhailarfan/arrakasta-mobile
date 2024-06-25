import 'dart:convert';
import 'package:my_flutter_project/welcome_screen.dart';
import 'package:my_flutter_project/product_screen.dart';
import 'package:my_flutter_project/api_endpoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:my_flutter_project/controllers/coin_controller.dart';
import 'package:my_flutter_project/controllers/profile_controller.dart';
import 'package:my_flutter_project/controllers/initial_screen_controller.dart';

class LoginController extends GetxController {
  // final CoinController coinController = Get.find<CoinController>();
  // final ProfileController profileController = Get.put(ProfileController());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  RxString _token = ''.obs;
  String? get token => _token.value;

  RxBool isLoggedIn = false.obs;
  RxBool isCollected = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadToken();
  }

  Future<void> loadToken() async {
    final SharedPreferences prefs = await _prefs;
    _token.value = prefs.getString('token') ?? '';
    isLoggedIn.value = _token.value.isNotEmpty;
    update();
  }


  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginEmail);
      Map body = {
        'email': emailController.text.trim(),
        'password': passwordController.text
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['success'] == true) {
          _token.value = json['data']['token'];
          final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('token', _token.value);
          print('Ini token lu bro $_token');
          isLoggedIn.value = true;
          emailController.clear();
          passwordController.clear();
          navigateAfterLogin();
          // Check if isCollected is true, navigate to ProductScreen, else WelcomeScreen
        //   if (coinController.coinModel.value.isCollected) {
        //     Get.offAll(() => ProductScreen());
        //   } else {
        //     Get.offAll(() => WelcomeScreen());
        //   }
        // } 
        }
        else {
          throw jsonDecode(response.body)['message'];
        }
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occurred";
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }
}
void navigateAfterLogin() {
  // Delegate the navigation logic to InitialScreenController
  final initialScreenController = Get.find<InitialScreenController>();
  initialScreenController.determineInitialScreen().then((screen) {
    Get.offAll(() => screen);
  });
}
