import 'dart:async';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'dart:io';

import '../utils/globals.dart';
import '../models/orang.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future getImage(String token, Orang orangData) async {
    FilePickerResult? file = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);

    if (file != null) {
      List<PlatformFile> files = file.files;
      String? path = files.single.path;

      final bytes = File(path!).readAsBytesSync();
      String img64 = base64Encode(bytes);

      // BlocProvider.of<AuthBloc>(context).add(
      //   ChangeProfilePic(
      //     token: token,
      //     image: img64,
      //     userData: userData
      //   ),
      // );
    }
  }

  String errorText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Template drawer from figma
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: lightPrimary,
              ),
              child: const Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: fadeBlack),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Text(
                'Profile',
                style: TextStyle(
                  color: profilePrimary,
                ),
              ),
            ),
            GestureDetector(
              child: const Icon(Icons.settings_outlined),
              onTap: () {
                Fluttertoast.showToast(
                    msg: "Logged out",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: backGround,
                    textColor: primaryBlack,
                    fontSize: 14.0);
                print('trigger logout here');
                // BlocProvider.of<AuthBloc>(context).add(
                //   LogOut()
                // );
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.messenger_outline),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mode_night_outlined),
            label: 'Night',
          ),
        ],
        currentIndex: 1,
        selectedItemColor: primaryBlack,
        unselectedItemColor: fadeBlack,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i) {},
      ),
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  // AVATAR & PROFILE
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                            radius: 50,
                            backgroundColor: backGround,
                            backgroundImage: Image.network(
                              // userData!.avatar == ""
                              //     ? "http://cdn.onlinewebfonts.com/svg/img_212716.png"
                              //     : userData.avatar,
                              "http://cdn.onlinewebfonts.com/svg/img_212716.png",
                              loadingBuilder: (BuildContext? context,
                                  Widget? child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child!;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ).image),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // userData.name + ' ' + userData.surname,
                                orangGlobal.orang1.nama,
                                style: TextStyle(
                                    color: profilePrimary, fontSize: 18),
                              ),
                              Text(
                                // userData.username,
                                orangGlobal.orang1.umur.toString(),
                                style:
                                    TextStyle(color: fadeBlack, fontSize: 16),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: GestureDetector(
                                  child: Text(
                                    "Change profile",
                                    style: TextStyle(
                                      color: profilePrimary,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  onTap: () {
                                    print('change pic logic here');
                                    // getImage(token!, userData!);
                                    // BlocProvider.of<AuthBloc>(context).add(
                                    //   ChangeProfilePic(
                                    //     token: authState.token,
                                    //     image: ""
                                    //   ),
                                    // );
                                  },
                                ),
                              ),
                              // authState is UpdateProfileFailed &&
                              //         errorText != ""
                              //     ? Text(
                              //         errorText,
                              //         style: TextStyle(
                              //             color: danger, fontSize: 10),
                              //       )
                              //     : Container()
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  // STRONG SIDE
                  Text(
                    "Strong Side:",
                    style: TextStyle(color: profilePrimary, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: backGroundSecondary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text("Analytics",
                              style: TextStyle(
                                  color: profileSecondary, fontSize: 15)),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        decoration: BoxDecoration(
                            color: backGroundSecondary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text("Perfectionism",
                              style: TextStyle(
                                  color: profileSecondary, fontSize: 15)),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        decoration: BoxDecoration(
                            color: backGroundSecondary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text("Analytics",
                              style: TextStyle(
                                  color: profileSecondary, fontSize: 15)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // WEAK SIDE
                  Text(
                    "Weak Side:",
                    style: TextStyle(color: profilePrimary, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: backGroundLightPrimary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text("Perfectionism",
                              style:
                                  TextStyle(color: lightPrimary, fontSize: 15)),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        decoration: BoxDecoration(
                            color: backGroundLightPrimary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text("Analytics",
                              style:
                                  TextStyle(color: lightPrimary, fontSize: 15)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // MY REPORTS
                  Text(
                    "My Reports:",
                    style: TextStyle(color: profilePrimary, fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  GridView.count(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: <Widget>[
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: backGroundProfilePrimary,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    Icon(
                                      Icons.person_outline,
                                      color: profilePrimary,
                                    ),
                                    const SizedBox(height: 5),
                                    Text("Astro-Psycological report",
                                        style: TextStyle(
                                            color: profilePrimary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 5),
                                    Text(
                                        "Some sort description of this type of reports",
                                        style: TextStyle(
                                            color: fadeBlack, fontSize: 12)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.bookmark,
                                  color: profilePrimary,
                                ),
                              ),
                              const SizedBox(width: 6)
                            ],
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: backGroundSecondary,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      color: profileSecondary,
                                    ),
                                    const SizedBox(height: 5),
                                    Text("Monthly prediction report",
                                        style: TextStyle(
                                            color: profileSecondary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 5),
                                    Text(
                                        "Some sort description of this type of reports",
                                        style: TextStyle(
                                            color: fadeBlack, fontSize: 12)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.bookmark,
                                  color: profileSecondary,
                                ),
                              ),
                              const SizedBox(width: 6)
                            ],
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: backGroundLightPrimary,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    Icon(
                                      Icons.check_box_outlined,
                                      color: lightPrimary,
                                    ),
                                    const SizedBox(height: 5),
                                    Text("Daily prediction",
                                        style: TextStyle(
                                            color: lightPrimary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 5),
                                    Text(
                                        "Some sort description of this type of reports",
                                        style: TextStyle(
                                            color: fadeBlack, fontSize: 12)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.bookmark,
                                  color: lightPrimary,
                                ),
                              ),
                              const SizedBox(width: 6)
                            ],
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: backGroundPink,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    Icon(
                                      Icons.favorite_outline,
                                      color: profilePink,
                                    ),
                                    const SizedBox(height: 5),
                                    Text("Love report",
                                        style: TextStyle(
                                            color: profilePink,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 5),
                                    Text(
                                        "Some sort description of this type of reports",
                                        style: TextStyle(
                                            color: fadeBlack, fontSize: 12)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.bookmark,
                                  color: profilePink,
                                ),
                              ),
                              const SizedBox(width: 6)
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
        //   });
        // } else {
        //   // return const Text(
        //   //   'LOGINED',
        //   //   style: TextStyle(
        //   //     fontSize: 40
        //   //   ),
        //   // );
        //   return Scaffold(
        //     body: LoadingIndicator(
        //       indicatorType: Indicator.ballPulse,
        //       colors: [profilePrimary!],
        //     ),
        //   );
        // }
        // return Image.asset(
        //   "assets/images/splash.png",
        //   fit: BoxFit.contain,
        //   height: double.infinity,
        //   width: double.infinity,
        //   alignment: Alignment.center,
        // );
      }),
    );
  }
}
