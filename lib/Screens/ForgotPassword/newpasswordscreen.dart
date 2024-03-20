import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Const/approute.dart';
import '../../Const/assets.dart';
import '../../Const/fonts.dart';
import '../Widget/submitbutton.dart';
import '../Widget/textformfield.dart';
import 'newpasswordcontroller.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  late NewPasswordController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(NewPasswordController());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.newPassKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Get.offAllNamed(Routes.loginScreen);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: Text(
            "Forgot Password",
            style: TextStyle(
              fontFamily: MyFont.myFont,
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Image.asset(Assets.newPassword),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: controller.newPasswordController,
                  inputFormatters: [],
                  hintText: "New Password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter New Password";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.confirmPasswordController,
                  inputFormatters: [],
                  hintText: "Confirm Password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Confirm Password";
                    } else if (controller.newPasswordController.text !=
                        controller.confirmPasswordController.text) {
                      return "Password Doesn't Match";
                    } else {
                      return null;
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: SubmitButton(
              isLoading: false,
              onTap: () {
                if (controller.newPassKey.currentState!.validate()) {
                  controller.forgotPasswordChange();
                }
              },
              title: "Change Password"),
        ),
      ),
    );
  }
}
