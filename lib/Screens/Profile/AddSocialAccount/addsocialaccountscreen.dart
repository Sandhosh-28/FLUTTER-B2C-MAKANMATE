import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makkanmate/Const/colors.dart';
import 'package:makkanmate/Const/fonts.dart';

import '../../../Const/assets.dart';
import '../../../Const/size.dart';

class AddSocialAccountScreen extends StatefulWidget {
  const AddSocialAccountScreen({super.key});

  @override
  State<AddSocialAccountScreen> createState() => _AddSocialAccountScreenState();
}

class _AddSocialAccountScreenState extends State<AddSocialAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: const Text("Add Social Media Account"),
      ),
      body: Center(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Add social accounts",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Add your social accounts for more security. You will go directly to their site.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: MyColors.textGrey,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.darkBlue,
                  disabledBackgroundColor: Colors.transparent,
                  minimumSize: Size(width(context), 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // <-- Radius
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.facebookLog,
                      scale: 3.9,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "CONNECT WITH FACEBOOK",
                      style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white),
                    ),
                  ],
                )),
            const SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.lightBlue,
                  disabledBackgroundColor: Colors.transparent,
                  minimumSize: Size(width(context), 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // <-- Radius
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.google,
                      scale: 3.9,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "CONNECT WITH GOOGLE",
                      style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white),
                    ),
                  ],
                )),
          ],
        ),
      )),
    );
  }
}
