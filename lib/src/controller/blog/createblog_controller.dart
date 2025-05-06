import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:universal_io/io.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';

class BlogController extends GetxController {
  var titleController = TextEditingController();
  var descriptionCatroller = TextEditingController();
  var categoryController = TextEditingController();
  var imageController = TextEditingController();

  var selectedImage = Rx<XFile?>(null);
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

    if (image == null) return const Text('No image selected');

    return kIsWeb
        ? Image.network(image.path, width: 200, height: 200, fit: BoxFit.cover)
        : Image.file(
          File(image.path),
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        );
  }
}
