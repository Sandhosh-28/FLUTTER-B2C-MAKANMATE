import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:makkanmate/WalkthroughScreen/screen3.dart';

import '../Const/approute.dart';
import '../Const/assets.dart';
import '../Const/colors.dart';
import '../Screens/Widget/submitbutton.dart';

class WalkthroughScreen2 extends StatefulWidget {
  const WalkthroughScreen2({super.key});

  @override
  State<WalkthroughScreen2> createState() => _WalkthroughScreen2State();
}

class _WalkthroughScreen2State extends State<WalkthroughScreen2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (builder) => const WalkthroughScreen3()));
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
                  Assets.walkthrough2,
                  scale: 4,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Free Delivery Offers",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Free delivery for new customers via apple\n"
                  "pay and other payment methods",
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
              Get.offAllNamed(Routes.walkthroughScreen3);
            },
            title: 'Get Started',
          ),
        ),
      ),
    );
  }
}
