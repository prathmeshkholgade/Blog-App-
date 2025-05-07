import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String phoneNumber;
  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "fullName": fullName,
      "email": email,
      "phoneNumber": phoneNumber,
    };
  }

  factory UserModel.fromjson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"],
      fullName: json["fullName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
    );
  }
}
