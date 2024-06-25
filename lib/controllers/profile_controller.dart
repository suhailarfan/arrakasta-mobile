import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:my_flutter_project/controllers/login_controller.dart';
import 'package:my_flutter_project/models/profile_model.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  ProfileModel? profileModel;
  Data? profileData;

  var host = 'http://203.175.11.204/';

  final loginController = Get.find<LoginController>();

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading(true);
      final Uri url = Uri.parse('http://203.175.11.204/api/v1/profile');

      final response = await http.get(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer ${loginController.token}', // Using the token from LoginController
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        profileModel = ProfileModel.fromJson(result);
        profileData = profileModel?.data;
      } else {
        print('Request failed with status: ${response.statusCode}.');
        print('Error message: ${response.body}');
      }
    } catch (e) {
      print('Error fetching data profile: $e');
    } finally {
      isLoading(false);
    }
  }
}
