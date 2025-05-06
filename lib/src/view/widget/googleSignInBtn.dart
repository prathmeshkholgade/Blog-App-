import 'package:blogapp/constants/image.dart';
import 'package:blogapp/src/controller/authentication/loginController.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class GoogleSignInBtn extends StatelessWidget {
  const GoogleSignInBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20),
        ),
        onPressed: () {
          Get.find<Logincontroller>().loginWithGoogle();
        },
        icon: Image(image: AssetImage(googleSignInLogo), width: 20),
        label: Text("SIGN-IN_WITH_GOOGLE"),
      ),
    );
  }
}
