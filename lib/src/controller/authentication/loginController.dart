import 'package:blogapp/service/firebaseService.dart';
import 'package:blogapp/src/controller/blog/createblog_controller.dart';
import 'package:blogapp/src/view/home.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';

class Logincontroller extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var blogController = Get.find<BlogController>();
  final RxBool isLoading = false.obs;
  final FirebaseService _firebaseService = FirebaseService();
  void login() async {
    isLoading.value = true;
    final email = emailController.text;
    final password = passwordController.text;
    if (email.isNotEmpty || password.isNotEmpty) {
      final result = await _firebaseService.loginUser(email, password);
      isLoading.value = false;
      result.fold(
        (e) {
          print(e);
          Get.snackbar(
            "Login failed",
            "Email or Password is incorrect",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFFE57373),
            colorText: const Color(0xFFFFFFFF),
          );
        },
        (value) {
          print("value $value");
          blogController.userId.value = value.uid ?? '';
          Get.offAll(HomePage());
          isLoading.value = false;
          Get.snackbar("success", "Login Successfully");
        },
      );
    }
    isLoading.value = false;
    print("$email $password");
  }

  void loginWithGoogle() async {
    final result = await _firebaseService.signInWithGoogle();
    //  final account = await _googleSignIn.signIn();
    result.fold(
      (e) {
        print(e);
        return Get.snackbar(
          "Google Sign-In Failed",
          "Something went wrong while signing in. Please try again",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 120),
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      },
      (value) {
        Get.off(HomePage());
        Get.snackbar(
          "Success",
          "Signed in with Google",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      },
    );
  }
}
