import 'dart:io';
import 'package:blogapp/core/commonWidget/textLogo.dart';
import 'package:blogapp/src/controller/blog/createblog_controller.dart';
import 'package:blogapp/src/utils/responsivepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class CreateBlogPage extends StatelessWidget {
  CreateBlogPage({super.key});
  final blogController = Get.find<BlogController>();

  @override
  Widget build(BuildContext context) {
      final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: TextLogo(),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              blogController.uploadBlog();
            },
            icon: Icon(Icons.upload),
          ),
        ],
      ),
      body: Obx(
        () =>
            blogController.isLoading.value
                ? Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )
                : Center(
                  child: Container(
                    margin: EdgeInsets.all(10.w),
                    width: getResponsiveWidth(context),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            blogController.getImage();
                          },
                          child:
                              blogController.selectedImage.value != null
                                  ? Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    height: 150,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      child: blogController.imagePreview(),
                                    ),
                                  )
                                  : Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    height: 150,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.black,
                                    ),
                                  ),
                        ),

                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Form(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: blogController.titleController,
                                  decoration: InputDecoration(
                                    hintText: "Title",
                                  ),
                                ),
                                TextFormField(
                                  controller:
                                      blogController.descriptionController,
                                  decoration: InputDecoration(
                                    hintText: "Description",
                                  ),
                                ),
                                TextFormField(
                                  controller: blogController.categoryController,
                                  decoration: InputDecoration(
                                    hintText: "Category",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }
}
