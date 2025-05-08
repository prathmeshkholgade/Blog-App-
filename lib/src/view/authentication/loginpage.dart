import 'package:blogapp/constants/image.dart';
import 'package:blogapp/core/commonWidget/textLogo.dart';
import 'package:blogapp/src/controller/authentication/loginController.dart';
import 'package:blogapp/src/utils/responsivepage.dart';
import 'package:blogapp/src/view/authentication/signuppage.dart';
import 'package:blogapp/src/view/widget/googleSignInBtn.dart';
import 'package:blogapp/src/view/widget/roundbutton.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loginpage extends StatelessWidget {
  Loginpage({super.key});
  final logincontroller = Get.find<Logincontroller>();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextLogo(), centerTitle: true),
      body: Center(                                            
        child: Container(
          width: getResponsiveWidthForSignup(context),
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: _key,
                child: Column(
                  children: [
                    TextFormField(
                      controller: logincontroller.emailController,
                      decoration: InputDecoration(hintText: "Email"),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? "Email is required"
                                  : null,
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: logincontroller.passwordController,
                      decoration: InputDecoration(hintText: "Password"),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? "Password is required"
                                  : null,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Text("Forgate Password ?")],
                    ),
                    SizedBox(height: 20),
                    // login btn
                    Obx(
                      () => Roundbutton(
                        title: "Login",
                        isLoading: logincontroller.isLoading.value,
                        onTap: () {
                          if (_key.currentState!.validate()) {
                            logincontroller.login();
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
                  text: "Don't have an Account ?",
                  style: TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(Signuppage());
                            },

                      text: "Signup",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Divider(),
              Text("OR"),
              SizedBox(height: 20),
              //g btn
              GoogleSignInBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
