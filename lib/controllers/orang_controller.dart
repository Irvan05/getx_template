import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_template/models/orang.dart';

import '../utils/globals.dart';

// REACTIVE
class OrangController extends GetxController {
  var orang1 = Orang(nama: 'budi', umur: 25).obs;

  var textEditiongController1 = TextEditingController();

  var umur = 1.obs;

  void nameToUpper() {
    orang1.update((val) {
      orang1.value.nama = orang1.value.nama.toString().toUpperCase();
    });
  }

  void incrementUmur() {
    umur++;
  }
}

// CONTOH DENGAN GETBUILDER (SIMPLE)
class OrangGetBuilderController extends GetxController {
  var orang1 = Orang(nama: 'budi', umur: 25);

  var umur = 1;

  void nameToUpper() {
    orang1.nama = orang1.nama.toString().toUpperCase();
    update();
  }

  void incrementUmur() {
    umur++;
    update();
  }
}

// ADVANCE
class OrangControllerDME extends GetxController {
  var orang1 = Orang(nama: 'budi', umur: 25).obs;

  var textEditiongController1 = TextEditingController();

  var umur = 1.obs;

  void nameToUpper() {
    orang1.update((val) {
      orang1.value.nama = orang1.value.nama.toString().toUpperCase();
    });
  }

  void incrementUmur() {
    umur++;
  }

  Future<void> setData() async {
    await secureStorage.write(key: "umur", value: '99');
    umur.value = int.parse(await secureStorage.read(key: "umur") ?? '404');
  }
}
