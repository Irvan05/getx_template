import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:getx_template/models/orang.dart';

import '../controllers/orang_controller.dart';

String serverLink = "https://testapi.nusantarainfrastructure.com";

Color? primaryColor = Colors.orange[900];
Color? lightPrimary = const Color(0xffff5d50);
Color? primaryBlack = Colors.black;
Color? fadeBlack = Colors.black54;
Color? danger = Colors.red;
Color? backGround = Colors.grey[200];

Color? profilePrimary = const Color(0xFF595085);
Color? profileSecondary = const Color(0xFF479696);
Color? profilePink = const Color(0xFFc93f8d);

Color? backGroundProfilePrimary = const Color(0xFFf6f5fd);
Color? backGroundSecondary = const Color(0xFFf5f9f9);
Color? backGroundPink = const Color(0xFFfdf9fb);
Color? backGroundLightPrimary = const Color(0xFFfff4f4);

// GLOBAL KEY SUDAH ADA DARI GETX
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// final navKey = GlobalKey<NavigatorState>();

// String? userToken;

FlutterSecureStorage secureStorage = const FlutterSecureStorage();

String authState = 'authorized';

final orangGlobal = Get.put(OrangGetBuilderController());
