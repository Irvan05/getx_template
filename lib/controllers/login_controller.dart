import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  late TextEditingController email;
  late TextEditingController password;
  var hiddenPass = true.obs;
  var rememberMe = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    email = TextEditingController();
    password = TextEditingController();
    // LEBIH BAIK TARUH DI AUTH
    // await GetStorage.init();

    final box = GetStorage();
    if (box.read('userCredential') != null) {
      final data = box.read('userCredential') as Map<String, dynamic>;
      email.text = data['email'];
      password.text = data['password'];
      rememberMe.value = data['rememberMe'];
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    email.dispose();
    password.dispose();
  }
}
