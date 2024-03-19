import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Const/assets.dart';
import '../../Const/fonts.dart';
import '../../Helper/extension.dart';
import '../Widget/submitbutton.dart';
import '../Widget/textformfield.dart';
import 'forgotpasswordcontroller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late ForgotPasswordController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(ForgotPasswordController());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.forgotPassKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.forgotPassword,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.emailController,
                  inputFormatters: [],
                  hintText: "Email Id",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " Enter the Email Id";
                    } else if (!validateEmail(value)) {
                      return "Invalid Email";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                SubmitButton(
                    isLoading: false,
                    onTap: () {
                      controller.exitingEmailCheck();
                    },
                    title: "Verify Email"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
