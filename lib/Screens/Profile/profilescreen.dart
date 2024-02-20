import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makkanmate/Const/colors.dart';

import '../../Const/approute.dart';
import '../../Const/assets.dart';
import '../Widget/CustomToggleButton.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isPushClick = false;
  bool isProClick = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.offAllNamed(Routes.userBottomNavBar);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text("Account Settings"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const Text(
              "Update your settings like notifications, payments, profile edit etc",
              style: TextStyle(
                fontSize: 18,
                color: MyColors.textGrey,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              onTap: () {
                Get.toNamed(Routes.editProfileScreen);
              },
              leading: Image.asset(
                Assets.accProfile,
                scale: 3,
              ),
              title: const Text(
                "Profile Information",
                style: TextStyle(fontSize: 16),
              ),
              subtitle: const Text(
                "Change your account information",
                style: TextStyle(
                  fontSize: 14,
                  color: MyColors.textGrey,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: () {
                Get.toNamed(Routes.changePasswordScreen);
              },
              leading: Image.asset(
                Assets.lock,
                scale: 3,
              ),
              title: const Text(
                "Change Password",
                style: TextStyle(fontSize: 16),
              ),
              subtitle: const Text(
                "Change your password",
                style: TextStyle(
                  fontSize: 14,
                  color: MyColors.textGrey,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: () {},
              leading: Image.asset(
                Assets.card,
                scale: 3,
              ),
              title: const Text(
                "Payment Methods",
                style: TextStyle(fontSize: 16),
              ),
              subtitle: const Text(
                "Add your credit & debit cards",
                style: TextStyle(
                  fontSize: 14,
                  color: MyColors.textGrey,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: () {
                Get.toNamed(Routes.addressListingScreen);
              },
              leading: Image.asset(
                Assets.location,
                scale: 3,
              ),
              title: const Text(
                "Locations",
                style: TextStyle(fontSize: 16),
              ),
              subtitle: const Text(
                "Add or remove your delivery locations",
                style: TextStyle(
                  fontSize: 14,
                  color: MyColors.textGrey,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: () {
                Get.toNamed(Routes.addSocialAccountScreen);
              },
              leading: Image.asset(
                Assets.facebook,
                scale: 3,
              ),
              title: const Text(
                "Add Social Account",
                style: TextStyle(fontSize: 16),
              ),
              subtitle: const Text(
                "Add Facebook, Twitter etc ",
                style: TextStyle(
                  fontSize: 14,
                  color: MyColors.textGrey,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: () {
                Get.toNamed(Routes.referFriendsScreen);
              },
              leading: Image.asset(
                Assets.share,
                scale: 3,
              ),
              title: const Text(
                "Refer to Friends",
                style: TextStyle(fontSize: 16),
              ),
              subtitle: const Text(
                "Get \$10 for referring friends",
                style: TextStyle(
                  fontSize: 14,
                  color: MyColors.textGrey,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: () {},
              leading: Image.asset(
                Assets.notify,
                scale: 3,
              ),
              title: const Text(
                "Push Notifications",
                style: TextStyle(fontSize: 16),
              ),
              subtitle: const Text(
                "For daily update you will get it",
                style: TextStyle(
                  fontSize: 14,
                  color: MyColors.textGrey,
                ),
              ),
              trailing: CustomToggleButton(
                value: isPushClick,
                onTap: (bool) {
                  setState(() {
                    isPushClick = !isPushClick;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: () {},
              leading: Image.asset(
                Assets.notify,
                scale: 3,
              ),
              title: const Text(
                "Promotional Notifications",
                style: TextStyle(fontSize: 16),
              ),
              subtitle: const Text(
                "For daily update you will get it",
                style: TextStyle(
                  fontSize: 14,
                  color: MyColors.textGrey,
                ),
              ),
              trailing: CustomToggleButton(
                value: isProClick,
                onTap: (bool) {
                  setState(() {
                    isProClick = !isProClick;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: () {},
              leading: Image.asset(
                Assets.rating,
                scale: 3,
              ),
              title: const Text(
                "Rate Us",
                style: TextStyle(fontSize: 16),
              ),
              subtitle: const Text(
                "Rate us play store, app store",
                style: TextStyle(
                  fontSize: 14,
                  color: MyColors.textGrey,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: () {},
              leading: Image.asset(
                Assets.faq,
                scale: 3,
              ),
              title: const Text(
                "FAQ",
                style: TextStyle(fontSize: 16),
              ),
              subtitle: const Text(
                "Frequently asked questions",
                style: TextStyle(
                  fontSize: 14,
                  color: MyColors.textGrey,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: () {},
              leading: Image.asset(
                Assets.logout,
                scale: 3,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(fontSize: 16),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
