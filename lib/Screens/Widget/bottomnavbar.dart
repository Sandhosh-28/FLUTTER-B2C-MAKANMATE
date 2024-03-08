import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:makkanmate/Screens/Dashboard/dashboardscreen.dart';

import '../../../Const/assets.dart';
import '../../../Const/colors.dart';
import '../Category/categoryscreen.dart';
import '../Order/orderscreen.dart';
import '../Profile/profilescreen.dart';

class UserBottomNavBar extends StatefulWidget {
  final int index;
  const UserBottomNavBar({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<UserBottomNavBar> createState() => _UserBottomNavBarState();
}

class _UserBottomNavBarState extends State<UserBottomNavBar> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.index;
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final tab = const [
    DashboardScreen(),
    CategoryScreen(),
    CategoryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tab.elementAt(selectedIndex),
      bottomNavigationBar: ClipRRect(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                activeIcon: SizedBox(
                  height: 30,
                  child: Image.asset(Assets.home1,
                      scale: 5, color: MyColors.primaryCustom),
                ),
                icon: SizedBox(
                  height: 30,
                  child: Image.asset(
                    Assets.home1,
                    scale: 5,
                  ),
                ),
                label: "Home"),
            BottomNavigationBarItem(
                activeIcon: SizedBox(
                  height: 30,
                  child: Image.asset(Assets.foodH,
                      scale: 5, color: MyColors.primaryCustom),
                ),
                icon: SizedBox(
                  height: 30,
                  child: Image.asset(
                    Assets.foodH,
                    scale: 5,
                  ),
                ),
                label: "Makan Mate"),
            BottomNavigationBarItem(
                activeIcon: SizedBox(
                  height: 30,
                  child: Image.asset(Assets.grocery,
                      scale: 5, color: MyColors.primaryCustom),
                ),
                icon: SizedBox(
                  height: 30,
                  child: Image.asset(
                    Assets.grocery,
                    scale: 5,
                  ),
                ),
                label: "Makan Mart"),
            BottomNavigationBarItem(
                activeIcon: SizedBox(
                  height: 30,
                  child: Image.asset(Assets.profile1,
                      scale: 5, color: MyColors.primaryCustom),
                ),
                icon: SizedBox(
                  height: 30,
                  child: Image.asset(
                    Assets.profile1,
                    scale: 5,
                  ),
                ),
                label: "Profile"),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: MyColors.primaryCustom,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
