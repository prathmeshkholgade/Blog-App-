import 'package:blogapp/core/commonWidget/textLogo.dart';
import 'package:blogapp/src/controller/authentication/logoutController.dart';
import 'package:blogapp/src/controller/blog/createblog_controller.dart';
import 'package:blogapp/src/view/createBlog.dart';
import 'package:blogapp/src/view/userBlog.dart';
import 'package:blogapp/src/view/widget/blogWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final logoutcontroller = Logoutcontroller();
  final blogController = Get.find<BlogController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextLogo(),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(UserBlog());
            },
            icon: Icon(Icons.person),
          ),
          ElevatedButton(
            onPressed: () {
              logoutcontroller.logout();
            },
            child: Text("Logout"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children:
                blogController.blogList
                    .map((blog) => Blogwidget(blog: blog))
                    .toList(),
          ),
        ),
      ),
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
