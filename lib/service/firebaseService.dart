import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Either<String, User>> signupUser(
    String email,
    String password,
    String fullName,
    String number,
  ) async {
    try {
      UserCredential userCredential;
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(userCredential.user!);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, User>> loginUser(String email, String password) async {
    try {
      UserCredential userCredential;
      userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(userCredential.user!);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, User>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(
            clientId:
                "842873462908-uckia047ae104lap85l5s9vlnuf5h5nt.apps.googleusercontent.com",
          ).signIn();
      if (googleUser == null) {
        return Left("Google sign in was cancelled");
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      return Right(userCredential.user!);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> logOutUser() async {
    try {
      await _auth.signOut();
      return Right("Loged Out Sucessfully");
    } catch (e) {
      return left(e.toString());
    }
  }
}
