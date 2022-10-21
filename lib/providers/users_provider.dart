import 'dart:convert';

import 'package:get/get.dart';

// JANGAN LUPA GANTI RULE FIREBASE BUAT TESTING
class UserProvider extends GetConnect {
  final url =
      "https://getx-connect-example-default-rtdb.asia-southeast1.firebasedatabase.app/";

  // CARA GET
  Future<Response> getUsers() => get(url + 'users.json');

  // POST
  Future<Response> postData(String name, String email, String phone) {
    final body = jsonEncode({"name": name, "email": email, "phone": phone});

    return post(url + 'users.json', body);
  }

  // DELETE
  Future<Response> deleteData(String id) {
    return delete(url + 'users/$id.json');
  }

  // PATCH
  Future<Response> editData(
      String id, String name, String email, String phone) {
    final body = jsonEncode({"name": name, "email": email, "phone": phone});

    return patch(url + 'users/$id.json', body);
  }
}
