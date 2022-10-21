import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_template/models/orang.dart';

import '../utils/globals.dart';

// REACTIVE
class ShopController extends GetxController {
  var count = 0.obs;
  var total = 0.obs;

  addCount() {
    count.value++;
  }

  removeCount() {
    count.value--;
  }

  addTotal() {
    total.value++;
  }

  removeTotal() {
    total.value--;
  }
}
