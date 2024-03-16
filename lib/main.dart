import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:makkanmate/Const/fonts.dart';

import 'Const/approute.dart';
import 'Const/colors.dart';
import 'locator/locator.dart';

void main() {
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MyColors.primaryCustom,
        appBarTheme: AppBarTheme(
            elevation: 1,
            toolbarHeight: 70,
            color: MyColors.appBarTheme,
            iconTheme: const IconThemeData(color: MyColors.black),
            titleTextStyle: TextStyle(
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: MyColors.black,
            )),
      ),
      initialRoute: Routes.walkthroughScreen1,
      // initialRoute: Routes.loginScreen,
      getPages: pages,
    );
  }
}
