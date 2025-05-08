import 'package:blogapp/core/commonWidget/textLogo.dart';
import 'package:blogapp/src/controller/authentication/signupController.dart';
import 'package:blogapp/src/utils/responsivepage.dart';
import 'package:blogapp/src/view/authentication/loginpage.dart';
import 'package:blogapp/src/view/widget/googleSignInBtn.dart';
import 'package:blogapp/src/view/widget/roundbutton.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class Signuppage extends StatelessWidget {
  Signuppage({super.key});
  final signupController = Get.find<Signupcontroller>();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextLogo(), centerTitle: true),
      body: Center(
        child: Container(
          width: getResponsiveWidthForSignup(context),
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                SizedBox(
                  child: Text(
                    "Create Account",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: signupController.fullNameController,
                        decoration: InputDecoration(hintText: "FullName"),
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? "Please enter your full name"
                                    : null,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: signupController.emailController,
                        decoration: InputDecoration(hintText: "Email"),
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? "Please enter your email"
                                    : null,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: signupController.numberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(hintText: "Number"),
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? "Phone number is required"
                                    : null,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: signupController.passwordController,
                        decoration: InputDecoration(hintText: "Password"),
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? "Phone number is password"
                                    : null,
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 20),
                      Obx(
                        () => Roundbutton(
                          title: "Signup",
                          isLoading: signupController.isLoading.value,
                          onTap: () {
                            if (_key.currentState!.validate()) {
                              signupController.signUp();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: "Already have an Account ?",
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(Loginpage());
                              },
                        text: "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text("OR"),
                SizedBox(height: 20),
                GoogleSignInBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
