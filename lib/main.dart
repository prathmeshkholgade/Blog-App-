import 'package:blogapp/firebase_options.dart';
import 'package:blogapp/src/controller/authentication/loginController.dart';
import 'package:blogapp/src/controller/authentication/signupController.dart';
import 'package:blogapp/src/controller/blog/createblog_controller.dart';
import 'package:blogapp/src/view/authentication/signuppage.dart';
import 'package:blogapp/src/view/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/instance_manager.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(BlogController());
  Get.put(Signupcontroller());
  Get.put(Logincontroller());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: user != null ? HomePage() : Signuppage(),
        );
      },
    );
  }
}
