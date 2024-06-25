import 'dart:convert';
import 'package:get/get.dart';
import 'package:my_flutter_project/models/chat_model.dart';
import 'package:http/http.dart' as http;
import 'package:my_flutter_project/controllers/login_controller.dart';

class ChatController extends GetxController {
  
  final loginController = Get.find<LoginController>();

  var messages = <ChatMessage>[].obs;
  var isLoading = false.obs;
  var host = 'http://203.175.11.204/';

  @override
  void onInit() {
    super.onInit();
    // Fetch messages when the controller is initialized
    fetchMessages();
    // Start polling for new messages
    startMessagePolling();
  }

  void startMessagePolling() {
    // Poll for new messages every 10 seconds
    // You can adjust the duration as needed
    Future.delayed(Duration(seconds: 10), () {
      fetchMessages();
      startMessagePolling(); // Call recursively to keep polling
    });
  }

  Future<void> fetchMessages() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('${host}api/v1/chats'),
        headers: {'Accept': 'application/json', 'Authorization': 'Bearer ${loginController.token}'},
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['success']) {
          messages.value = (result['data'] as List).map((e) => ChatMessage.fromJson(e)).toList();
        }
      }
    } catch (e) {
      print('Error fetching messages: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse('${host}api/v1/chats'),
        headers: {'Accept': 'application/json', 'Authorization': 'Bearer ${loginController.token}'},
        body: {'message': message},
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['success']) {
          fetchMessages();
        }
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }
}
