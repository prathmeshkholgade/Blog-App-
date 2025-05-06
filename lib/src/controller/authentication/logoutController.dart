import 'package:blogapp/service/firebaseService.dart';
import 'package:blogapp/src/view/authentication/signuppage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Logoutcontroller extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();

  void logout() async {
    final result = await _firebaseService.logOutUser();
    result.fold(
      (e) {
        print(e);
      },
      (msg) {
        Get.offAll(() => Signuppage());
        Get.snackbar("success", msg);
      },
    );
  }
}
