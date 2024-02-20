import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:makkanmate/Screens/Dashboard/dashboardscreen.dart';

import '../../../Const/assets.dart';
import '../../../Const/colors.dart';
import '../Category/categoryscreen.dart';
import '../Order/orderscreen.dart';
import '../Profile/profilescreen.dart';

class UserBottomNavBar extends StatefulWidget {
  const UserBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<UserBottomNavBar> createState() => _UserBottomNavBarState();
}

class _UserBottomNavBarState extends State<UserBottomNavBar> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final tab = const [
    DashboardScreen(),
    CategoryScreen(),
    OrderScreen(),
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
                activeIcon: Image.asset(Assets.home1,
                    scale: 3, color: MyColors.primaryCustom),
                icon: Image.asset(
                  Assets.home1,
                  scale: 3,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Image.asset(Assets.category1,
                      scale: 3, color: MyColors.primaryCustom),
                ),
                icon: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Image.asset(
                    Assets.category1,
                    scale: 3,
                  ),
                ),
                label: "Category"),
            BottomNavigationBarItem(
                activeIcon: Image.asset(Assets.order1,
                    scale: 3, color: MyColors.primaryCustom),
                icon: Image.asset(
                  Assets.order1,
                  scale: 3,
                ),
                label: "Order"),
            BottomNavigationBarItem(
                activeIcon: Image.asset(Assets.profile1,
                    scale: 3, color: MyColors.primaryCustom),
                icon: Image.asset(
                  Assets.profile1,
                  scale: 3,
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
