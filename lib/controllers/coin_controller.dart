import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_flutter_project/models/coin_model.dart';
import 'package:my_flutter_project/controllers/login_controller.dart';
import 'package:my_flutter_project/product_screen.dart';

class CoinController extends GetxController {
  var coinModel = CoinModel().obs;
  var isLoading = true.obs;

  final LoginController loginController = Get.find<LoginController>();

  @override
  void onInit() {
    fetchCoinData();
    super.onInit();
  }

  Future<void> fetchCoinData() async {
    try {
      final response = await http.get(
        Uri.parse('http://203.175.11.204/api/v1/coins'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${loginController.token}',
          'Accept': 'application/json', // Add the Accept header
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        if (data != null) {
          coinModel.value = CoinModel.fromJson(data);
        } else {
          coinModel.value = CoinModel(id: 0, userId: 0, total: 0, isCollected: false); // Use default values
        }
      } else {
        print('Failed to fetch coin data: ${response.body}');
      }
    } catch (e) {
      print('Error during coin data fetch: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> collectCoin() async {
  try {
    final payload = {
      'total': 10,
      'type': 'increment',
    };
    print('Collecting coin with token: ${loginController.token}');
    print('Request payload: ${jsonEncode(payload)}');

    final response = await http.put(
      Uri.parse('http://203.175.11.204/api/v1/coins'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${loginController.token}',
        'Accept': 'application/json',
      },
      body: jsonEncode(payload),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      if (data != null) {
        coinModel.update((coin) {
          coin?.total = data['total']['total']; // Update the total coins
          coin?.isCollected = data['total']['is_collected'] == 1; // Update the isCollected value to true
        });
        Get.dialog(
          AlertDialog(
            title: Text('Congratulations!'),
            content: Text('You have collected your daily coin!'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.offAll(() => ProductScreen());
                },
                child: Text('Okey!'),
              ),
            ],
          ),
        );
      } else {
        print('Failed to parse coin data: ${response.body}');
      }
    } else {
      print('Failed to collect coin: ${response.body}');
    }
  } catch (e) {
    print('Error during coin collection: $e');
  }
}

}
