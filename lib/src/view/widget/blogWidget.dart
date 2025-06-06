import 'package:blogapp/service/fireStoreService.dart';
import 'package:blogapp/src/controller/blog/createblog_controller.dart';
import 'package:blogapp/src/model/blogModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:sizer/sizer.dart' as sizer;

class Blogwidget extends StatelessWidget {
  final Blogmodel blog;
  final blogController = Get.find<BlogController>();

  Blogwidget({super.key, required this.blog});
  final FireStoreService _fireStoreService = FireStoreService();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double boxWidth;

    if (screenWidth < 600) {
      boxWidth = 100.w; // Mobile
    } else if (screenWidth >= 600 && screenWidth < 1024) {
      boxWidth = 45.w; // Tablet
    } else {
      boxWidth = 30.w; // Desktop
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(bottom: 16),
      height: 300,
      width: boxWidth,
      // sizer.Device.screenType == sizer.ScreenType.tablet
      //     ? 50.w
      //     : //this is for mobile
      //     100.w,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              blog.image,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.black54.withAlpha(80),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  blog.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4),
                Text(
                  blog.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 4),

                FutureBuilder(
                  future: _fireStoreService.authorNameByuId(blog.userId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("...");
                    } else if (snapshot.hasError) {
                      return Text("...");
                    } else if (snapshot.hasData) {
                      return snapshot.data!.fold(
                        (error) => Text(blog.category),
                        (name) => Text(name),
                      );
                    } else {
                      return Text("error");
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
