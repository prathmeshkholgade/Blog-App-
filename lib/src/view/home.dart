import 'package:blogapp/core/commonWidget/textLogo.dart';
import 'package:blogapp/src/controller/authentication/logoutController.dart';
import 'package:blogapp/src/view/createBlog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final logoutcontroller = Logoutcontroller();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextLogo(),
        actions: [
          ElevatedButton(
            onPressed: () {
              logoutcontroller.logout();
            },
            child: Text("Logout"),
          ),
        ],
      ),
      body: Column(),
      floatingActionButton: Container(
        padding: EdgeInsets.all(10),
        child: FloatingActionButton(
          onPressed: () {
            Get.to(CreateBlogPage());
          },
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
