import 'package:get/get.dart';
import 'package:getx_template/controllers/orang_controller.dart';
import 'package:getx_template/pages/getx_storage_example.dart';
import 'package:getx_template/pages/navigation_example_getx.dart';
import 'package:getx_template/routes/route_names.dart';

import '../utils/bindings.dart';
import '../pages/getx_connect_example.dart';
import '../pages/profile_page.dart';
import '../pages/add_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: RouteNames.page_2, page: () => const Page2()),
    GetPage(name: RouteNames.page_3, page: () => const Page3()),
    GetPage(name: RouteNames.page_4, page: () => Page4()),
    GetPage(name: RouteNames.page_5, page: () => Page5()),
    GetPage(name: RouteNames.page_6 + '/:id?', page: () => Page6()),
    GetPage(
        name: RouteNames.page_7, page: () => Page7(), binding: orangBinding()),

    // getxconnect/ get http tutorial
    GetPage(
      name: RouteNames.getxConnectHome,
      page: () => GetxConnectHomePage(),
    ),
    GetPage(
      name: RouteNames.profile,
      page: () => ProfilePage(),
      binding: ProfileB(),
    ),
    GetPage(
      name: RouteNames.add,
      page: () => AddPage(),
      binding: AddUserB(),
    ),

    // GETXSTORAGE
    GetPage(
        name: RouteNames.getStoragePage,
        page: () => GetxStoragePage(),
        bindings: [LoginBinding(), AuthBinding()]),
  ];
}
