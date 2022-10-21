import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_template/controllers/auth_controller.dart';
import 'package:getx_template/controllers/login_controller.dart';

class GetxStoragePage extends StatelessWidget {
  GetxStoragePage({Key? key}) : super(key: key);

  // final lc = Get.put(LoginController());
  final AuthController ac = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('GETX STORAGE EXAMPLE'),
        ),
        body: ac.obx(
          (state) => ac.isAuth.isTrue ? GSEHomePage() : GSELoginPage(),
        ));
  }
}

class GSELoginPage extends StatelessWidget {
  GSELoginPage({Key? key}) : super(key: key);

  final LoginController loginController = Get.find();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: loginController.email,
              autocorrect: false,
              decoration: InputDecoration(
                  labelText: 'Email', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(
              () => TextField(
                controller: loginController.password,
                obscureText: loginController.hiddenPass.value,
                autocorrect: false,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        // iconSize: 20,
                        onPressed: () => loginController.hiddenPass.toggle(),
                        icon: loginController.hiddenPass.isTrue
                            ? Icon(Icons.remove_red_eye)
                            : Icon(Icons.remove_red_eye_outlined)),
                    labelText: 'Password',
                    border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Obx(() => CheckboxListTile(
                  value: loginController.rememberMe.value,
                  onChanged: (_) => loginController.rememberMe.toggle(),
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('Remember me'),
                )),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  authController.login(
                      loginController.email.text,
                      loginController.password.text,
                      loginController.rememberMe.value);
                },
                child: Text('Login'))
          ],
        ),
      ),
    );
  }
}

class GSEHomePage extends StatelessWidget {
  GSEHomePage({Key? key}) : super(key: key);

  final LoginController loginController = Get.find();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            authController.logout(loginController.rememberMe.value);
            Get.back();
          },
          child: Text('Logout')),
    );
  }
}
