import 'package:flutter/material.dart';
import 'package:my_flutter_project/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:my_flutter_project/main.dart';
import 'package:my_flutter_project/product_screen.dart';
import 'package:my_flutter_project/controllers/coin_controller.dart';
import 'package:my_flutter_project/controllers/login_controller.dart';
// import 'package:rive/rive.dart';


class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final ProfileController profileController =  Get.put(ProfileController());
  final CoinController coinController = Get.find<CoinController>();
  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Center(
                child: Icon(
                  Icons.person_outlined,
                  size: 150,
                  color: Colors.black,
                ),
              ),
              Center(
  child: Obx(() {
    return profileController.isLoading.value
        ? const CircularProgressIndicator() 
        : Text.rich(
            TextSpan(
              text: 'Selamat Datang, ',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 28,
              ),
              children: [
                TextSpan(
                  text: '${profileController.profileData?.name ?? ""}!',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          );
  }),
),

              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Ketuk bunga untuk mendapatkan koin!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w100,
                      color: Colors.black
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Center(
                child: GestureDetector(
                  onTap: () async{
                    await coinController.collectCoin();
                  },
                child: 
                SizedBox(
                    height: 450,
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            'assets/img/bunga.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Image.asset(
                            'assets/img/bunga.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Image.asset(
                            'assets/img/bunga.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                // Container(
                //   height: 200,
                //   width: 200,
                //   child: GestureDetector(
                //     onTap: () {
                //       // Handle user tap on the animation (e.g., update coin count)
                //       //updateCoin();
                //     },
                //     child: 
                //     RiveAnimation.asset(
                //     'assets/animations/russian_doll.riv',
                //     fit: BoxFit.cover,
                //     animations: ['Body_Loop'],
                //     onInit: _onRiveInit,
                //   ),
                //   ),
                // ),
                ),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }



}