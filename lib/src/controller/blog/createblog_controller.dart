import 'dart:convert';
import 'dart:io';
import 'package:blogapp/service/fireStoreService.dart';
import 'package:blogapp/src/model/blogModel.dart';
import 'package:blogapp/src/view/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:universal_io/io.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';

class BlogController extends GetxController {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var categoryController = TextEditingController();
  var imageController = TextEditingController();
  var isLoading = false.obs;
  var blogList = <Blogmodel>[].obs;
  var selectedImage = Rx<XFile?>(null);
  var userId = ''.obs;
  final FireStoreService _fireStoreService = FireStoreService();
  final _auth = FirebaseAuth.instance;
  var userBlog = <Blogmodel>[].obs;

  void updateUserBlogs() {
    userBlog.value =
        blogList
            .where((blog) => blog.userId.toString() == userId.value.toString())
            .toList();
  }

  Future<void> getImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        selectedImage.value = pickedFile;
        print('Selected image: ${selectedImage.value}');
      } else {
        print('No image selected');
      }
    } catch (e) {
      print(e);
    }
  }

  Widget imagePreview() {
    final XFile? image = selectedImage.value;

    if (image == null) return Text('No image selected');

    return kIsWeb
        ? Image.network(image.path, width: 200, height: 200, fit: BoxFit.cover)
        : Image.file(
          File(image.path),
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        );
  }

  Future<String?> uploadImageWithClodinary(XFile imageFile) async {
    const cloudName = "dn5llhtrn";
    const uploadPreset = "flutter app";
    final url = Uri.parse(
      "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
    );

    try {
      var request;

      if (kIsWeb) {
        List<int> imageBytes = await imageFile.readAsBytes();
        String base64Image = base64Encode(imageBytes);

        request =
            http.MultipartRequest('POST', url)
              ..fields['upload_preset'] = uploadPreset
              ..fields['file'] = "data:image/png;base64,$base64Image";
      } else {
        request =
            http.MultipartRequest('POST', url)
              ..fields['upload_preset'] = uploadPreset
              ..files.add(
                await http.MultipartFile.fromPath('file', imageFile.path),
              );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final resJson = json.decode(response.body);
        print("Image URL: ${resJson['secure_url']}");
        return resJson['secure_url'];
      } else {
        print("Upload failed: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Upload error: $e");
      return null;
    }
  }

  Future<void> uploadBlog() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        Get.snackbar("Error", "User not logged in");
        return;
      }

      if (titleController.text.isEmpty ||
          descriptionController.text.isEmpty ||
          categoryController.text.isEmpty ||
          selectedImage.value == null) {
        Get.snackbar("Error", "All fields including image are required");
        return;
      }

      isLoading.value = true;

      final imageUrl = await uploadImageWithClodinary(selectedImage.value!);
      if (imageUrl == null) {
        Get.snackbar("Error", "Image upload failed");
        isLoading.value = false;
        return;
      }

      final blog = Blogmodel(
        title: titleController.text.trim(),
        description: descriptionController.text,
        category: categoryController.text,
        image: imageUrl,
        userId: currentUser.uid,
      );
      print(currentUser.uid);
      final result = await _fireStoreService.saveBlogInDb(blog);
      result.fold(
        (e) {
          print("DB error: $e");
          isLoading.value = false;
        },
        (_) {
          blogList.add(blog);
          Get.off(HomePage());
          isLoading.value = false;
          Get.snackbar("Success", "Blog uploaded successfully");
          clearAllFileds();
        },
      );
    } catch (e) {
      print("Upload Error: $e");
      isLoading.value = false;
    }
  }

  void getAllBlogs() async {
    final result = await _fireStoreService.getBloagdata();
    result.fold((e) => print(e), (value) {
      print(value);
      blogList.value = value;
    });
  }

  clearAllFileds() {
    titleController.clear();
    descriptionController.clear();
    categoryController.clear();
    selectedImage.value = null;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userId.value = _auth.currentUser?.uid ?? '';
    getAllBlogs();
    ever(userId, (_) {
      getAllBlogs();
      updateUserBlogs();
    });

    everAll([blogList, userId], (_) {
      if (userId.value.isNotEmpty && blogList.isNotEmpty) {
        updateUserBlogs();
      }
    });
  }
}
