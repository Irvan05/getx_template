import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/controllers/orang_controller.dart';
import 'package:getx_template/controllers/usersC.dart';
import 'package:getx_template/pages/dashboard.dart';
import 'package:getx_template/pages/dependency_management_example.dart';
import 'package:getx_template/pages/getx_storage_example.dart';
import 'package:getx_template/pages/getx_connect_example.dart';
import 'package:getx_template/pages/navigation_example_getx.dart';
import 'package:getx_template/pages/workers.dart';
import 'package:getx_template/routes/page_routes.dart';
import 'package:getx_template/routes/route_names.dart';
import 'package:getx_template/utils/bindings.dart';
import 'package:getx_template/utils/get_localization.dart';

import 'utils/globals.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // PASTIKAN GUNAKAN GET.PUT HANYA SAAT PERTAMA INISIALISASI, SELANJUTNYA GUNAKAN FIND
  // GETX SANGAT JARANG MEMBUTUHKAN SATATEFUL WIDGET KARENA  BISA DIGANTIKAN DENGAN GETBUILDER
  // PASTIKAN ROUTING MENGGUNAKAN GET.TO DAN MENGGUNAKAN GETMATERIALAPP DI HOME
  // SUPAYA DISPOSE TEXTCONTROLLER DLL DILAKUKAN SECARA OTOMATIS
  // JUGA MENARUH SEMUA COMPONENT CONTROLLER (TEXTCONTROLLER DLL) DALAM GETX CONTROLLER

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: MyLocalization(),
      theme: ThemeData.light(),
      locale: Locale('en'),
      home: MainPage(),
      // CONTOH NAMED ROUTE
      getPages: AppPages.pages,
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'.tr),
        actions: [
          IconButton(
              onPressed: () {
                print(Get.locale.toString());
                if (Get.locale.toString() == 'en') {
                  Get.updateLocale(Locale('id'));
                } else {
                  Get.updateLocale(Locale('en'));
                }
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () => Get.toNamed(RouteNames.getStoragePage),
              child: Text('GETX STORAGE TUTORIAL')),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () =>
                  Get.to(() => GetxConnectHomePage(), binding: UserB()),
              child: Text('GETX CONNECT TUTORIAL')),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                print(Get.theme.toString());
                Get.changeTheme(
                    Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
              },
              child: Text('CHANGE THEME WITH GETX')),
          SizedBox(
            height: 20,
          ),
          Text(
            'example'.trParams({'kow': 'bener'}),
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () => Get.to(() => DependencyManagementExamplePage()),
              child: Text('Dependency Management Example')),
          SizedBox(
            height: 20,
          ),
          DialogExample(),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Get.snackbar('this is title', 'this is message',
                    animationDuration: Duration(milliseconds: 200),
                    duration: Duration(seconds: 2),
                    borderWidth: 2,
                    borderColor: Colors.amber,
                    onTap: (data) => print('snackbar tap ${data.toString()}'));
              },
              child: Text('GETX SNACKBAR EXAMPLES')),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () => Get.to(() => NavigationExampleGetxPage()),
              child: Text('NAVIGATION EXAMPLES')),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () => Get.to(() => WorkersPage()),
              child: Text('WORKERS EXAMPLE')),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                // CARA BIASA TANPA GETX
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const DashboardPage(),
                //     ));
                Get.to(() => DashboardPage());
              },
              child: Text('CONTOH DASHBOARD')),
          SizedBox(
            height: 20,
          ),
          ObxExample(),
          SizedBox(
            height: 20,
          ),
          GetxExample(),
          SizedBox(
            height: 20,
          ),
          GetBuilderExample(),
          SizedBox(
            height: 20,
          ),
          GetBuilderUniqueId(),
          SizedBox(
            height: 20,
          ),
          ParamThrowExample(),
          SizedBox(
            height: 20,
          ),
          BasicRoutingExample()
        ],
      )),
    );
  }
}

// CONTOH DIALOG GETX
class DialogExample extends StatelessWidget {
  const DialogExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () => Get.defaultDialog(
                          title: 'this is title',
                          middleText: 'this is message',
                          barrierDismissible: false,
                          backgroundColor: Colors.amber,
                          textCancel: 'Cancel',
                          cancelTextColor: Colors.red,
                          textConfirm: 'Confirm',
                          confirmTextColor: Colors.green,
                          onConfirm: () {},
                          actions: [
                            ElevatedButton(
                              onPressed: () => Get.back(),
                              child: Text('pilihan1'),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('pilihan2'),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('pilihan3'),
                            )
                          ]),
                  child: Text('default dialog')),
              ElevatedButton(
                  onPressed: () {
                    Get.dialog(AlertDialog(
                      title: Text('this is title'),
                      content: Text('this is content'),
                    ));
                  },
                  child: Text('dialog')),
              // GENERAL DIALOG USE CASENYA SANGAT JARANG
              ElevatedButton(
                  onPressed: () {
                    Get.generalDialog(
                        pageBuilder: (context, animation, secondaryAnimation) {
                      return AlertDialog(
                        title: Text('this is title'),
                        content: Text('this is content'),
                      );
                    });
                  },
                  child: Text('general dialog'))
            ],
          ),
          ElevatedButton(
              onPressed: () {
                Get.bottomSheet(Container(
                  padding: EdgeInsets.fromLTRB(
                      20, 20, 20, MediaQuery.of(context).viewInsets.bottom),
                  color: Colors.amberAccent,
                  child: Center(
                    child: ListView(
                      children: [
                        TextField(
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () => Get.back(), child: Text('Submit'))
                      ],
                    ),
                  ),
                ));
              },
              child: Text('Bottom sheet with GETX')),
        ],
      ),
    );
  }
}

// CONTOH DENGAN OBX
class ObxExample extends StatelessWidget {
  ObxExample({Key? key}) : super(key: key);

  final orangA = Get.put(OrangController());
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() => Column(
            children: [
              Text(
                'CONTOH DENGAN OBX',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "nama saya ${orangA.orang1.value.nama}",
              ),
              Text(
                "umur: ${orangA.umur}",
              ),
              TextButton(
                  onPressed: () => orangA.nameToUpper(),
                  child: const Text('Uppercase nama')),
              ElevatedButton(
                  onPressed: () => orangA.incrementUmur(),
                  child: const Icon(Icons.add))
            ],
          )),
    );
  }
}

// CONTOH DENGAN GETX
class GetxExample extends StatelessWidget {
  const GetxExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GetX<OrangController>(
          builder: (controller) => Column(
                children: [
                  Text(
                    'CONTOH DENGAN GETX',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "nama saya ${controller.orang1.value.nama}",
                  ),
                  Text(
                    "umurnya: ${controller.umur}",
                  ),
                  TextButton(
                      onPressed: () => controller.nameToUpper(),
                      child: const Text('Uppercase nama')),
                  ElevatedButton(
                    onPressed: () =>
                        Get.find<OrangController>().incrementUmur(),
                    child: const Icon(Icons.add),
                  )
                ],
              )),
    );
  }
}

// CONTOH DENGAN GETBUILDER (BISA MEMBUAT STATELESS SEOLAH2 STATEFUL)
class GetBuilderExample extends StatelessWidget {
  GetBuilderExample({Key? key}) : super(key: key);

  final orangB = Get.put(OrangGetBuilderController());
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GetBuilder<OrangGetBuilderController>(
          // BISA DGN CONTROLLER ATAU DENGAN PUT MENGGUNAKAN VARIABEL
          init: OrangGetBuilderController(),
          // JUGA BISA MEMASUKKAN DIDCHANGEDEPENDENCIES DAN DISPOSE
          // TANPA PERLU MENGGUNAKAN STATEFUL WIDGET
          // UNTUK DIDUPDATEWIDGET TETAP PERLU SATATEFUL
          builder: (controller) => Column(
                children: [
                  Text(
                    'CONTOH DENGAN GETBUILDER',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "nama saya ${controller.orang1.nama}",
                  ),
                  Text(
                    "umurnya: ${controller.umur}",
                  ),
                  TextButton(
                      onPressed: () => controller.nameToUpper(),
                      child: const Text('Uppercase nama')),
                  // BISA 2 CARA, PAKAI PUT JIKA FUNGSI TIDAK SATU PARENT
                  ElevatedButton(
                      onPressed: () => orangB.incrementUmur(),
                      child: const Icon(Icons.add)),
                  ElevatedButton(
                      onPressed: () => controller.incrementUmur(),
                      child: const Icon(Icons.add)),
                ],
              )),
    );
  }
}

// CONTOH UNIQUE ID GETBUILDER
class GetBuilderUniqueId extends StatelessWidget {
  GetBuilderUniqueId({Key? key}) : super(key: key);

  final orangB = Get.put(OrangGetBuilderController());
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'CONTOH UNIQUE ID GETBUILDER',
            style: TextStyle(fontSize: 20),
          ),
          GetBuilder<OrangGetBuilderController>(
              init:
                  OrangGetBuilderController(), // ATAU BISA DENGAN PUT MENGGUNAKAN VARIABEL
              id: 'budi1',
              builder: (controller) => Column(
                    children: [
                      Text(
                        "nama saya ${controller.orang1.nama}",
                      ),
                      Text(
                        "umurnya: ${controller.umur}",
                      ),
                      TextButton(
                          onPressed: () => controller.nameToUpper(),
                          child: const Text('Uppercase nama'))
                    ],
                  )),
          GetBuilder<OrangGetBuilderController>(
              init:
                  OrangGetBuilderController(), // ATAU BISA DENGAN PUT MENGGUNAKAN VARIABEL
              id: 'budi2',
              builder: (controller) => Column(
                    children: [
                      Text(
                        "nama saya ${controller.orang1.nama}",
                      ),
                      Text(
                        "umurnya: ${controller.umur}",
                      ),
                      TextButton(
                          onPressed: () => controller.nameToUpper(),
                          child: const Text('Uppercase nama'))
                    ],
                  )),
          TextButton(
              onPressed: () {
                orangB.incrementUmur();
                orangB.update(['budi1']);
              },
              child: const Text('update budi1'))
        ],
      ),
    );
  }
}

// MELEMPAR PARAM KE COMPONENT/WIDGET LAIN
class ParamThrowExample extends StatelessWidget {
  ParamThrowExample({Key? key}) : super(key: key);

  final orangA = Get.put(OrangController());
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() => Column(
            children: [
              Text(
                'CONTOH PARAM THROW/EXTRACT',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "nama saya ${orangA.orang1.value.nama}",
              ),
              Text(
                "umur: ${orangA.umur}",
              ),
              TextButton(
                  onPressed: () => orangA.nameToUpper(),
                  child: const Text('Uppercase nama')),
              ExtractedWidgetExample(/*orangA: orangA*/),
            ],
          )),
    );
  }
}

class ExtractedWidgetExample extends StatelessWidget {
  ExtractedWidgetExample({
    Key? key,
    // required this.orangA,
  }) : super(key: key);

  // BISA DIKIRIM ATAU PAKE FIND
  // final OrangController orangA;
  // final orangA = Get.find<OrangController>();
  // bisa begini juga
  final OrangController orangA = Get.find();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        orangA.incrementUmur();
      },
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}

// BASIC GETX ROUTING AND BENEFIT WITH INCLASS CONTROLLER
class BasicRoutingExample extends StatelessWidget {
  BasicRoutingExample({Key? key}) : super(key: key);
  final orangA = Get.put(OrangController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() => Column(
            children: [
              Text(
                "nama saya ${orangA.orang1.value.nama}",
              ),
              Text(
                "umur: ${orangA.umur}",
              ),
              TextButton(
                  onPressed: () => orangA.nameToUpper(),
                  child: const Text('Uppercase nama')),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => NextPageInGetxController());
                  },
                  child: Text('change page'))
            ],
          )),
    );
  }
}

class InGetxController extends GetxController {
  final myC = TextEditingController();
}

class NextPageInGetxController extends StatelessWidget {
  NextPageInGetxController({Key? key}) : super(key: key);

  final textC = Get.put(InGetxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InGetxController'),
      ),
      body: Center(
          child: TextField(
        controller: textC.myC,
      )),
    );
  }
}

/*
final orangA = Get.put(OrangController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('This is title'),
          ),
          body: Center(
            child: Obx(() => Column(
                  children: [
                    Text(
                      "nama saya ${orangA.orang1.value.nama}",
                    ),
                    Text(
                      "umur: ${orangA.umur}",
                    ),
                    TextButton(
                        onPressed: () => orangA.nameToUpper(),
                        child: const Text('Uppercase nama'))
                  ],
                )),
          ),
          floatingActionButton: ExtractedWidgetExample(/*orangA: orangA*/),
        ));
  }
}

class ExtractedWidgetExample extends StatelessWidget {
  ExtractedWidgetExample({
    Key? key,
    // required this.orangA,
  }) : super(key: key);

  // BISA DIKIRIM ATAU PAKE FIND
  // final OrangController orangA;
  final orangA = Get.find<OrangController>();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        orangA.incrementUmur();
      },
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
  */
