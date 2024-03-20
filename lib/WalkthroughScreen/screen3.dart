import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:makkanmate/Screens/Dashboard/dashboardscreen.dart';

import '../Const/approute.dart';
import '../Const/assets.dart';
import '../Const/colors.dart';
import '../Screens/Login/loginscreen.dart';
import '../Screens/Widget/bottomnavbar.dart';
import '../Screens/Widget/submitbutton.dart';

class WalkthroughScreen3 extends StatefulWidget {
  const WalkthroughScreen3({super.key});

  @override
  State<WalkthroughScreen3> createState() => _WalkthroughScreen3State();
}

class _WalkthroughScreen3State extends State<WalkthroughScreen3>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (builder) => const LoginScreen()));
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Adjust the duration as needed
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.walkthrough3,
                  scale: 4,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Choose Your Food",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Easily Finds Your Type of Food Cravings and\n"
                  "You'll Get Delivery in wide range",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: MyColors.lightGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
          child: SubmitButton(
            isLoading: false,
            onTap: () {
              Get.offAllNamed(Routes.loginScreen);
            },
            title: 'Get Started',
          ),
        ),
      ),
    );
  }
}
