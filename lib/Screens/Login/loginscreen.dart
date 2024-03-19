import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makkanmate/Const/colors.dart';
import 'package:makkanmate/Screens/Widget/submitbutton.dart';
import 'package:makkanmate/Screens/Widget/textformfield.dart';

import '../../Const/approute.dart';
import '../../Const/assets.dart';
import '../../Const/fonts.dart';
import '../../Const/size.dart';
import '../../Helper/extension.dart';
import 'logincontroller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(LoginController());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.loginKey,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Sign In"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome to",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 10),
              const Text("Enter your Phone number or Email for sign in, Or",
                  style: TextStyle(
                    fontSize: 16,
                    color: MyColors.textGrey,
                  )),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.registrationScreen);
                },
                child: const Text("Create a New Account",
                    style: TextStyle(
                      fontSize: 16,
                      color: MyColors.primaryCustom,
                    )),
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.emailController,
                inputFormatters: [EmailInputFormatter()],
                hintText: "Email Address",
                suffixIcon: const Icon(Icons.phone_android),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter email id";
                  } else if (!validateEmail(value)) {
                    return "Invalid Email Id";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.passwordController,
                inputFormatters: [],
                hintText: "Password",
                obscureText: controller.isVis.value ? false : true,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      controller.isVis.value = !controller.isVis.value;
                    });
                  },
                  icon: controller.isVis.value
                      ? const Icon(Icons.visibility_outlined)
                      : const Icon(Icons.visibility_off_outlined),
                ),
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Enter Valid Password";
                  }
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                    onPressed: () {
                      Get.offAllNamed(Routes.forgotPasswordScreen);
                    },
                    child: const Text("Forgot Password?",
                        style: TextStyle(
                          fontSize: 16,
                          color: MyColors.textGrey,
                        ))),
              ),
              const SizedBox(height: 20),
              SubmitButton(
                  isLoading: false,
                  onTap: () {
                    if (controller.loginKey.currentState!.validate()) {
                      controller.loginKey.currentState?.save();
                      controller.onLoginTapped();
                    } else {
                      print("Fields are Empty");
                    }
                  },
                  title: "SIGN IN"),
              const SizedBox(height: 20),
              const Center(
                child: Text("Or",
                    style: TextStyle(
                      fontSize: 16,
                      color: MyColors.textGrey,
                    )),
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
                    children: [
                      Image.asset(
                        Assets.facebookLog,
                        scale: 3.9,
                      ),
                      const SizedBox(width: 30),
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
                    children: [
                      Image.asset(
                        Assets.google,
                        scale: 3.9,
                      ),
                      const SizedBox(width: 30),
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
        ),
      ),
    );
  }
}
