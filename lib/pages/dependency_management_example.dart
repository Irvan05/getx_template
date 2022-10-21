import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/controllers/orang_controller.dart';
import 'package:getx_template/controllers/shop_controller.dart';

class DependencyManagementExamplePage extends StatelessWidget {
  DependencyManagementExamplePage({Key? key}) : super(key: key);

  // final orangA = Get.put(OrangControllerDME());
  // GUNAKAN PERMANENT SUPAYA CONTROLLER TIDAK DIHAPUS WALAUPUN HALAMAN HILANG
  final orangA = Get.put(OrangControllerDME(), permanent: true);
  // TAG BERFUNGSI SEPERTI ID
  // final orangA = Get.put(OrangControllerDME(), tag: 'esy');
  // LAZYPUT AKAN CREATE SAAT ADA YANG GUNAKAN DAN FENIX TRUE SUPAYA BISA DIREBUILD JIKA DIPANGGIL SEHABIS DIHAPUS
  final orangB =
      Get.lazyPut(() => OrangControllerDME(), tag: 'text-only', fenix: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dependency Management Example'),
      ),
      body: DMEHome(),
    );
  }
}

class DMEHome extends StatelessWidget {
  DMEHome({Key? key}) : super(key: key);

  // GUNAKAN FIND SUPAYA TIDAK BUAT CCONTROLLER BARU
  final OrangControllerDME orangA = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Obx(() => Text(
                'umur: ${orangA.umur}',
                style: TextStyle(fontSize: 18),
              )),
          TextField(
            controller: orangA.textEditiongController1,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          ElevatedButton(
              onPressed: () => orangA.incrementUmur(),
              child: Text('Tambah umur')),
          ElevatedButton(
              onPressed: () => Get.to(DMEPage1()),
              child: Text('Go to async example')),
          ElevatedButton(
              onPressed: () => Get.to(GetCreateExample()),
              child: Text('Go to create example'))
        ],
      ),
    );
  }
}

class DMEPage1 extends StatelessWidget {
  DMEPage1({Key? key}) : super(key: key);
  final OrangControllerDME orangA = Get.find(tag: 'text-only');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PAGE1'),
      ),
      body: Center(
        child: Column(
          children: [
            Obx(() => Text(
                  'umur: ${orangA.umur}',
                  style: TextStyle(fontSize: 18),
                )),
            TextField(
              controller: orangA.textEditiongController1,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            ElevatedButton(
                onPressed: () => orangA.setData(), child: Text('set umur'))
          ],
        ),
      ),
    );
  }
}

class GetCreateExample extends StatelessWidget {
  GetCreateExample({Key? key}) : super(key: key);

  final ShopController shopCTotal =
      Get.put(ShopController(), tag: 'total', permanent: false);
  final quantityShopC = Get.create(() => ShopController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CREATE EXAMPLE'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 300,
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return ShopItem();
              },
            ),
          ),
          Obx(() => Text(
                'total: ${shopCTotal.total.value}',
                style: TextStyle(fontSize: 20),
              )),
        ],
      )),
      // floatingActionButton: FloatingActionButton(
      //   child: Obx(() => Text(
      //         '${shopCTotal.total.value}',
      //         style: TextStyle(fontSize: 20),
      //       )),
      //   onPressed: () {},
      // ),
    );
  }
}

class ShopItem extends StatelessWidget {
  ShopItem({Key? key}) : super(key: key);
  final ShopController shopC = Get.find();
  final ShopController shopCTotal = Get.find(tag: 'total');

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () {
              shopC.removeCount();
              shopCTotal.removeTotal();
            },
            icon: Icon(Icons.remove)),
        Obx(() => Text(
              '${shopC.count}',
              style: TextStyle(fontSize: 20),
            )),
        IconButton(
            onPressed: () {
              shopC.addCount();
              shopCTotal.addTotal();
            },
            icon: Icon(Icons.add)),
      ],
    );
  }
}
