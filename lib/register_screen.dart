import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_project/controllers/register_controller.dart';
import 'package:my_flutter_project/main.dart';
import 'package:my_flutter_project/controllers/login_controller.dart';



class RegisterScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
  final RegisterationController _registerationController = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                'Buat Akun Baru',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Silahkan isi kolom berikut dengan data anda.',
                style: TextStyle(
                  fontFamily: 'Rag',
                  fontWeight: FontWeight.w100,
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InputTextFieldWidget(
                    textEditingController: _registerationController.nameController,
                    hintText: 'Nama Lengkap',
                  ),
                  SizedBox(height: 10),
                  InputTextFieldWidget(
                    textEditingController: _registerationController.emailController,
                    hintText: 'Alamat Email',
                  ),
                  SizedBox(height: 10),
                  InputTextFieldWidget(
                    textEditingController: _registerationController.passwordController,
                    hintText: 'Kata Sandi',
                    obscureText: true,
                  ),
                  SizedBox(height: 30),
                  SubmitButton(
                    onPressed: () {
                      _registerationController.registerWithEmail();
                    },
                    title: 'Register',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const SubmitButton({Key? key, required this.onPressed, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.25),
            offset: Offset(0, 0),
            blurRadius: 2,
            spreadRadius: 1,
          )
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide.none,
          ),
          backgroundColor: '#B8257C'.toColor()
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class InputTextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool obscureText;
  InputTextFieldWidget({
    required this.textEditingController,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: TextField(
        controller: textEditingController,
        obscureText: obscureText,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          fillColor: Colors.white54,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.only(bottom: 15, left: 10, right: 10), // Adjust padding
          focusColor: Colors.white60,
        ),
      ),
    );
  }
}
