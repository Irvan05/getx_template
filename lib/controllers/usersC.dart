import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/providers/users_provider.dart';
import '../models/user.dart';

class UsersC extends GetxController with StateMixin<String> {
  var users = List<User>.empty().obs;

  void snackBarError(String msg) {
    Get.snackbar(
      "ERROR",
      msg,
      duration: Duration(seconds: 2),
    );
  }

  @override
  void onInit() {
    // change('Init page', status: RxStatus.success());
    initPage();
    super.onInit();
  }

  void initPage() {
    UserProvider().getUsers().then((response) {
      print(jsonEncode(response.body));
      print('response:');
      print(response.body);

      // AS JSON OBJECTS
      final data = response.body as Map<String, dynamic>;

      data.forEach((key, val) {
        users.add(
          User(
            id: key,
            name: val['name'],
            email: val['email'],
            phone: val['phone'],
          ),
        );
      });

      change('Init page', status: RxStatus.success());
    });
  }

  // BIKIN GET SENDIRI

  void add(String name, String email, String phone) {
    change('Loading', status: RxStatus.loading());
    if (name != '' && email != '' && phone != '') {
      if (email.contains("@")) {
        // JANGAN LUPA TRY CATCH
        UserProvider().postData(name, email, phone).then((response) {
          print(response.body);

          if (response.statusCode == 200)
            change('Success', status: RxStatus.success());

          users.add(
            User(
              id: response.body['name'],
              name: name,
              email: email,
              phone: phone,
            ),
          );

          Get.back();
        }, onError: (err) => change(err.toString(), status: RxStatus.error()));
      } else {
        snackBarError("Masukan email valid");
      }
    } else {
      snackBarError("Semua data harus diisi");
    }
  }

  User userById(String id) {
    return users.firstWhere((element) => element.id == id);
  }

  void edit(String id, String name, String email, String phone) {
    change('Loading', status: RxStatus.loading());
    if (name != '' && email != '' && phone != '') {
      if (email.contains("@")) {
        UserProvider().editData(id, name, email, phone).then((response) {
          if (response.statusCode == 200)
            change('Success', status: RxStatus.success());

          final user = userById(id);
          user.name = name;
          user.email = email;
          user.phone = phone;
          users.refresh();

          Get.back();
        }, onError: (err) => change(err.toString(), status: RxStatus.error()));
      } else {
        snackBarError("Masukan email valid");
      }
    } else {
      snackBarError("Semua data harus diisi");
    }
  }

  Future<bool> delete(String id) async {
    bool _deleted = false;
    await Get.defaultDialog(
      title: "DELETE",
      middleText: "Apakah kamu yakin untuk menghapus data user ini?",
      textConfirm: "Ya",
      confirmTextColor: Colors.white,
      onConfirm: () {
        change('Loading', status: RxStatus.loading());
        print('idnya: ' + id);
        Get.back();

        UserProvider().deleteData(id).then((response) {
          if (response.statusCode == 200)
            change('Success', status: RxStatus.success());

          users.removeWhere((element) => element.id == id);
          _deleted = true;
        }, onError: (err) => change(err.toString(), status: RxStatus.error()));
      },
      textCancel: "Tidak",
    );
    return _deleted;
  }
}
