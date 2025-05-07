import 'package:blogapp/src/model/blogModel.dart';
import 'package:blogapp/src/model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class FireStoreService {
  final _firestore = FirebaseFirestore.instance;

  Future<Either<String, Unit>> saveBlogInDb(Blogmodel blog) async {
    try {
      await _firestore.collection("blogs").add(blog.toJson());
      return right(unit);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<Blogmodel>>> getBloagdata() async {
    try {
      final querySnapshot = await _firestore.collection("blogs").get();
      final blogs =
          querySnapshot.docs
              .map((doc) => Blogmodel.fromJson(doc.data()))
              .toList();
      return right(blogs);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, Unit>> saveUserData(UserModel user) async {
    try {
      await _firestore.collection("users").doc(user.uid).set(user.toJson());
      return right(unit);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, String>> authorNameByuId(String uid) async {
    try {
      final snapshot =
          await _firestore
              .collection("users")
              .where("uid", isEqualTo: uid)
              .limit(1)
              .get();

      if (snapshot.docs.isNotEmpty) {
        return right(snapshot.docs.first.get("fullName"));
      } else {
        return left("User not found");
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
