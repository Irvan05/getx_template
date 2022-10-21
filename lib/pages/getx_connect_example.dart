import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/routes/route_names.dart';
import '../controllers/usersC.dart';

class GetxConnectHomePage extends GetView<UsersC> {
  // GETVIEW HARUS MENGGUNAKAN CONTROLLER
  // final usersC = Get.find<UsersC>();
  @override
  Widget build(BuildContext context) {
    // controller.pageStart();
    return Scaffold(
      appBar: AppBar(
        title: Text("ALL USERS"),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(RouteNames.add),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
          child: controller.obx(
        onLoading: Center(
          child: Text("Loading..."),
        ),
        // onEmpty:
        // onError: (error) =>
        (state) => Obx(
          () => Padding(
            padding: const EdgeInsets.all(20),
            child: controller.users.isEmpty
                ? Center(
                    child: Text("Belum ada data: $state"),
                  )
                : ListView.builder(
                    itemCount: controller.users.length,
                    itemBuilder: (context, i) => ListTile(
                      leading: CircleAvatar(),
                      title: Text("${controller.users[i].name}"),
                      subtitle: Text("${controller.users[i].email}"),
                      trailing: IconButton(
                        onPressed: () =>
                            controller.delete(controller.users[i].id),
                        icon: Icon(
                          Icons.delete_forever,
                          color: Colors.red[900],
                        ),
                      ),
                      onTap: () => Get.toNamed(
                        RouteNames.profile,
                        arguments: controller.users[i].id,
                      ),
                    ),
                  ),
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.get_app_rounded),
      ),
    );
  }
}
