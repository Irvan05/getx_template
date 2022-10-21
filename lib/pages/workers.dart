import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/controllers/workers_controller.dart';

class WorkersPage extends StatelessWidget {
  WorkersPage({Key? key}) : super(key: key);

  final workerC = Get.put(WorkerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WORKERS'),
        actions: [
          IconButton(
              onPressed: () => workerC.reset(), icon: Icon(Icons.refresh))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Text(
                  'Terjadi sesuatu : ${workerC.count} X',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) => workerC.change(),
                decoration: InputDecoration(border: OutlineInputBorder()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
