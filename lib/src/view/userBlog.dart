import 'package:blogapp/core/commonWidget/textLogo.dart';
import 'package:blogapp/src/controller/blog/createblog_controller.dart';
import 'package:blogapp/src/model/blogModel.dart';
import 'package:blogapp/src/view/widget/blogWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:sizer/sizer.dart';

class UserBlog extends StatelessWidget {
  UserBlog({super.key});

  final blogController = Get.find<BlogController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
        ),
        title: TextLogo(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(2.w),
          child: Obx(
            () => Wrap(
              children:
                  blogController.blogList
                      .map((blog) => Blogwidget(blog: blog))
                      .toList(),
            ),
          ),
        ),
      ),

      // body: Obx(
      //   () => SingleChildScrollView(
      //     child: Column(
      //       children:
      //           blogController.userBlog
      //               .map((blog) => Blogwidget(blog: blog))
      //               .toList(),
      //     ),
      //   ),
      // ),
    );
  }
}
