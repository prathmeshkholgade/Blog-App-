import 'package:blogapp/service/firebaseService.dart';
import 'package:blogapp/src/view/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';

class Signupcontroller extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fullNameController = TextEditingController();
  var numberController = TextEditingController();
  final RxBool isLoading = false.obs;
  final FirebaseService _firebaseService = FirebaseService();
  signUp() async {
    isLoading.value = true;
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final fullName = fullNameController.text.trim();
    final number = numberController.text.trim();
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        fullName.isNotEmpty &&
        number.isNotEmpty) {
      print("$email $password $fullName $number");
      final result = await _firebaseService.signupUser(
        email,
        password,
        fullName,
        number,
      );
      result.fold(
        (e) {
          print("error $e");
          isLoading.value = false;
          Get.snackbar("Error", e.toString());
        },
        (value) {
          Get.offAll(HomePage());
          print("value $value");
          isLoading.value = false;
          Get.snackbar(
            "success",
            "Signin successfully",
            backgroundColor: Colors.blue[200],
          );
        },
      );
    } else {
      isLoading.value = false;
      Get.snackbar(
        "Input Error",
        "Please fill in all the fields",
        backgroundColor: Colors.orangeAccent,
      );
    }
  }
}
