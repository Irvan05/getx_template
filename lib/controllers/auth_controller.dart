import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController with StateMixin {
  var isAuth = false.obs;

  Map<String, String> hardCodeLoginCheck = {
    'email': 'admin@admin.com',
    'password': 'asd123'
  };

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    change('Init page', status: RxStatus.success());

    await GetStorage.init();

    // AUTO LOGIN
    // final box = GetStorage();
    // if (box.read('userCredential') != null) {
    //   final data = box.read('userCredential') as Map<String, dynamic>;
    //   login(data['email'], data['password'], data['rememberMe']);
    // }
  }

  void errorDialog(String msg) {
    Get.defaultDialog(title: 'OOps something error', middleText: msg);
  }

  void login(String email, String password, bool rememberMe) {
    change('Loading', status: RxStatus.loading());
    print('init login');
    if (email != '' && password != '') {
      if (!GetUtils.isEmail(email)) {
        errorDialog('Email not valid');
        return;
      }
      if (email != hardCodeLoginCheck['email'] ||
          password != hardCodeLoginCheck['password']) {
        errorDialog('Invalid login credential');
        return;
      }

      if (rememberMe) {
        final box = GetStorage();
        box.write('userCredential',
            {'email': email, 'password': password, 'rememberMe': rememberMe});
      } else {
        final box = GetStorage();
        box.remove('userCredential');
      }

      isAuth.value = true;
    } else {
      errorDialog('Login failed');
    }
    change('Init page', status: RxStatus.success());
  }

  void logout(bool rememberMe) {
    if (!rememberMe) {
      final box = GetStorage();
      box.erase();
    }
    isAuth.value = false;
  }
}
