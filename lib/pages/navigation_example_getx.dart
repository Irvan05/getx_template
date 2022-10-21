import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/main.dart';
import 'package:getx_template/routes/route_names.dart';

import '../controllers/orang_controller.dart';

class NavigationExampleGetxPage extends StatelessWidget {
  const NavigationExampleGetxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Navigation with GETX'),
          // REMEMBER TO PUT GETMATERIALPAGE ON MAIN
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Colors.teal),
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // GETX NAVIGATOR TANPA NAMA
                  Text(
                    'TANPA NAMA',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        navigator!
                            .push(MaterialPageRoute(builder: (_) => Page2()));
                      },
                      child: Text('with getx global navigator')),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(Page2());
                      },
                      child: Text('with Get.to')),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(Page4(),
                            arguments: {'testString': 'Param dari page1'});
                      },
                      child: Text('Get.to with param')),
                  ElevatedButton(
                      onPressed: () async {
                        String data = await Get.to(
                          Page5(),
                        );
                        print('data from page: $data');
                      },
                      child: Text('Get.to awaiting result from page')),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(() => Page7(), binding: BindingsBuilder(() {
                          Get.put(OrangControllerDME());
                        }));
                      },
                      child: Text('with Get.to and binding')),
                  Text(
                    'NAMED ROUTE LEBIH BAIK DIGUNAKAN HANYA UNTUK FLUTTER WEB',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Get.toNamed(RouteNames.page_2);
                      },
                      child: Text('with Get.toNamed')),
                  ElevatedButton(
                      onPressed: () {
                        Get.toNamed(RouteNames.page_6 +
                            '/24?name=benar sekali&desc=eset');
                      },
                      child: Text('with dynamic Get.toNamed')),
                  ElevatedButton(
                      onPressed: () {
                        Get.toNamed(RouteNames.page_7);
                      },
                      child: Text('with Get.toNamed and binding')),
                ],
              ),
            ),
          ),
        ));
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page2'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => navigator!.pop(),
                child: Text('Back with navigator')),
            ElevatedButton(
                onPressed: () => Get.back(), child: Text('Back with Get.back')),
            // Get.off sama seperti push replacement
            ElevatedButton(
                onPressed: () => Get.off(Page3()),
                child: Text('Get.off ke page3')),
            // Get.offAll sama seperti pushandremoveuntil (menghilangkan semua stack lalu push)
            ElevatedButton(
                onPressed: () => Get.offAll(MainPage()),
                child: Text('Get.offAll ke main page'))
          ],
        ),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page3'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => Get.back(), child: Text('Back with Get.back')),
            // Get.offAll sama seperti pushandremoveuntil (menghilangkan semua stack lalu push)
            ElevatedButton(
                onPressed: () => Get.offAll(MainPage()),
                child: Text('Get.offAll ke main page'))
          ],
        ),
      ),
    );
  }
}

class Page4 extends StatelessWidget {
  Page4({Key? key}) : super(key: key);

  Map<String, String> data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page4'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              data['testString'].toString(),
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
                onPressed: () => Get.back(), child: Text('Back with Get.back')),
          ],
        ),
      ),
    );
  }
}

class Page5 extends StatelessWidget {
  Page5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page5'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => Get.back(result: 'String from page5'),
                child: Text('return data to page1')),
          ],
        ),
      ),
    );
  }
}

class Page6 extends StatelessWidget {
  const Page6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page6'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'data from url: ${Get.parameters}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              'name from url: ${Get.parameters['name']}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              'desc: ${Get.parameters['desc']}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            ElevatedButton(
                onPressed: () => Get.back(result: 'String from page5'),
                child: Text('back')),
          ],
        ),
      ),
    );
  }
}

class Page7 extends StatelessWidget {
  Page7({Key? key}) : super(key: key);
  final OrangControllerDME orangA = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page2'),
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
                onPressed: () => Get.back(), child: Text('Back with Get.back')),
          ],
        ),
      ),
    );
  }
}
