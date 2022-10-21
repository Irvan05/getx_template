import 'package:get/get.dart';
import 'package:getx_template/controllers/auth_controller.dart';
import 'package:getx_template/controllers/login_controller.dart';
import 'package:getx_template/controllers/usersC.dart';

import '../../controllers/addC.dart';
import '../controllers/orang_controller.dart';
import '../controllers/profileC.dart';

class AddUserB implements Bindings {
  @override
  void dependencies() {
    Get.put(AddC());
  }
}

class orangBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(OrangControllerDME());
  }
}

class ProfileB implements Bindings {
  @override
  void dependencies() {
    Get.put(ProfileC());
  }
}

class UserB implements Bindings {
  @override
  void dependencies() {
    Get.put(UsersC());
  }
}

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
