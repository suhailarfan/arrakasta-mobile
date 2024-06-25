import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_project/login_screen.dart';
import 'package:my_flutter_project/register_screen.dart';
import 'package:my_flutter_project/main.dart';
import 'package:my_flutter_project/controllers/login_controller.dart';
import 'package:my_flutter_project/controllers/register_controller.dart';
import 'package:my_flutter_project/controllers/coin_controller.dart';

class HomeScreen extends StatefulWidget {
  // HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LoginController? loginController;
  RegisterationController? registerController;
  CoinController? coinController;

  @override
  void initState() {
    super.initState();
    initializeControllers();
  }

  void initializeControllers() {
    // Initialize controllers
    loginController = Get.find<LoginController>();
    registerController = Get.put(RegisterationController());
    coinController = Get.find<CoinController>();
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              Center(
                child: SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/img/logo_arrakasta.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Halo ArrakastaGirls!',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 28,
                        letterSpacing: 0.7,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Silahkan login dengan akun kamu atau buat akun baru jika belum memiliki akun.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w100,
                      color: Colors.black,
                      letterSpacing: -0.2,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 50),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => RegisterScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: '#B8257C'.toColor(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Buat Akun Baru',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        'Sudah punya akun? ',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                          // Get.to(() => LoginScreen());
                        },
                        child: Text(
                          'Login Disini',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w200,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
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
