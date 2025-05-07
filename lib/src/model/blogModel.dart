import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class Blogmodel {
  final String title;
  final String description;
  final String category;
  final String image;
  final String userId;

  Blogmodel({
    required this.title,
    required this.description,
    required this.category,
    required this.image,
    required this.userId,
  });
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'image': image,
      'userId': userId,
    };
  }

  factory Blogmodel.fromJson(Map<String, dynamic> json) {
    return Blogmodel(
      title: json["title"],
      description: json["description"],
      category: json["category"],
      image: json["image"],
      userId: json["userId"],
    );
  }
}
