import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makkanmate/Const/colors.dart';
import 'package:makkanmate/Screens/Profile/ReferFriends/referfriendscontroller.dart';
import 'package:makkanmate/Screens/Widget/submitbutton.dart';
import 'package:makkanmate/Screens/Widget/textformfield.dart';

import '../../../Const/assets.dart';

class ReferFriendsScreen extends StatefulWidget {
  const ReferFriendsScreen({super.key});

  @override
  State<ReferFriendsScreen> createState() => _ReferFriendsScreenState();
}

class _ReferFriendsScreenState extends State<ReferFriendsScreen> {
  late ReferFriendsController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(ReferFriendsController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        title: const Text("Refer to Friends"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                Assets.referFriend,
                scale: 3,
              ),
              const SizedBox(height: 20),
              const Text(
                "Refer a Friend, Get \$10",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Get \$10 in credits when someone sign up using your refer link",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: MyColors.textGrey,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                  controller: controller.linkController,
                  hintText: "https://ui8.net/76738b",
                  readOnly: true,
                  enabled: false,
                  inputFormatters: [],
                  prefixIcon: Image.asset(
                    Assets.arr,
                    scale: 3,
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {}, icon: Icon(Icons.copy_rounded))),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 8, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SubmitButton(isLoading: false, onTap: () {}, title: "EMAIL"),
            const SizedBox(height: 15),
            SubmitButton(
              isLoading: false,
              onTap: () {},
              title: "OTHERS",
              color: Colors.transparent,
              textColor: MyColors.textGrey,
              shadowColor: Colors.transparent,
              borderSide: const BorderSide(
                color: MyColors.grey,
                width: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
