import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makkanmate/WalkthroughScreen/screen2.dart';

import '../Const/approute.dart';
import '../Const/assets.dart';
import '../Const/colors.dart';
import '../Screens/Widget/submitbutton.dart';

class WalkthroughScreen1 extends StatefulWidget {
  const WalkthroughScreen1({super.key});

  @override
  State<WalkthroughScreen1> createState() => _WalkthroughScreen1State();
}

class _WalkthroughScreen1State extends State<WalkthroughScreen1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (builder) => const WalkthroughScreen2()));
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
                  Assets.walkthrough1,
                  scale: 4,
                ),
                const SizedBox(height: 20),
                const Text(
                  "All Your Favorites",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Order from the best local restaurants\n"
                  "with easy, on demand delivery",
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
              Get.offAllNamed(Routes.walkthroughScreen2);
            },
            title: 'Get Started',
          ),
        ),
      ),
    );
  }
}
