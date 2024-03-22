import 'package:get/get.dart';

import '../Screens/Category/ProductDetail/productdetailscreen.dart';
import '../Screens/Category/ProductFeatured/FeaturedScreen.dart';
import '../Screens/Category/ProductListing/productlistingscreen.dart';
import '../Screens/Dashboard/dashboardscreen.dart';
import '../Screens/ForgotPassword/forgototppasswordscreen.dart';
import '../Screens/ForgotPassword/forgotpasswordscreen.dart';
import '../Screens/ForgotPassword/newpasswordscreen.dart';
import '../Screens/Login/loginscreen.dart';
import '../Screens/Order/orderdetailscreen.dart';
import '../Screens/Order/orderscreen.dart';
import '../Screens/PlaceOrder/placeorderscreen.dart';
import '../Screens/Profile/AddSocialAccount/addsocialaccountscreen.dart';
import '../Screens/Profile/Address/addnewaddressscreen.dart';
import '../Screens/Profile/Address/addresslistingscreen.dart';
import '../Screens/Profile/ChangePassword/changepasswordscreen.dart';
import '../Screens/Profile/EditProfile/editprofilescreen.dart';
import '../Screens/Profile/ReferFriends/referfriendsscreen.dart';
import '../Screens/Register/otpscreen.dart';
import '../Screens/Register/registrationscreen.dart';
import '../Screens/SplashScreen/splashscreen.dart';
import '../Screens/Widget/bottomnavbar.dart';
import '../WalkthroughScreen/screen1.dart';
import '../WalkthroughScreen/screen2.dart';
import '../WalkthroughScreen/screen3.dart';

class Routes {
  static const String initialRoute = "/SplashScreen";
  static const String walkthroughScreen1 = "/WalkthroughScreen1";
  static const String walkthroughScreen2 = "/WalkthroughScreen2";
  static const String walkthroughScreen3 = "/WalkthroughScreen3";
  static const String registrationScreen = "/RegistrationScreen";
  static const String loginScreen = "/LoginScreen";
  static const String userBottomNavBar = "/UserBottomNavBar";
  static const String dashboardScreen = "/DashboardScreen";
  static const String editProfileScreen = "/EditProfileScreen";
  static const String changePasswordScreen = "/ChangePasswordScreen";
  static const String addSocialAccountScreen = "/AddSocialAccountScreen";
  static const String referFriendsScreen = "/ReferFriendsScreen";
  static const String addressListingScreen = "/AddressListingScreen";
  static const String addNewAddressScreen = "/AddNewAddressScreen";
  static const String productListingScreen = "/ProductListingScreen";
  static const String productDetailScreen = "/ProductDetailScreen";
  static const String featuredDetailScreen = "/FeaturedDetailScreen";
  static const String placeOrderScreen = "/PlaceOrderScreen";
  static const String oTPScreen = "/OTPScreen";
  static const String forgotPasswordScreen = "/ForgotPasswordScreen";
  static const String forgotPasswordOTPScreen = "/ForgotPasswordOTPScreen";
  static const String newPasswordScreen = "/NewPasswordScreen";
  static const String orderScreen = "/OrderScreen";
  static const String orderDetailScreen = "/OrderDetailScreen";
}

final pages = [
  GetPage(name: Routes.initialRoute, page: () => const SplashScreen()),
  GetPage(name: Routes.productDetailScreen, page: () => const ProductDetailScreen()),
  GetPage(name: Routes.featuredDetailScreen, page: () => const FeatureedScreen()),
  GetPage(
      name: Routes.walkthroughScreen1, page: () => const WalkthroughScreen1()),
  GetPage(
      name: Routes.walkthroughScreen2, page: () => const WalkthroughScreen2()),
  GetPage(
      name: Routes.walkthroughScreen3, page: () => const WalkthroughScreen3()),
  GetPage(
      name: Routes.registrationScreen, page: () => const RegistrationScreen()),
  GetPage(name: Routes.loginScreen, page: () => const LoginScreen()),
  GetPage(
      name: Routes.userBottomNavBar,
      page: () => const UserBottomNavBar(index: 0)),
  GetPage(name: Routes.dashboardScreen, page: () => const DashboardScreen()),
  GetPage(
      name: Routes.editProfileScreen, page: () => const EditProfileScreen()),
  GetPage(
      name: Routes.changePasswordScreen,
      page: () => const ChangePasswordScreen()),
  GetPage(
      name: Routes.addSocialAccountScreen,
      page: () => const AddSocialAccountScreen()),
  GetPage(
      name: Routes.referFriendsScreen, page: () => const ReferFriendsScreen()),
  GetPage(
      name: Routes.addressListingScreen,
      page: () => const AddressListingScreen()),
  GetPage(
      name: Routes.addNewAddressScreen,
      page: () => const AddNewAddressScreen()),
  GetPage(
      name: Routes.productListingScreen,
      page: () => const ProductListingScreen()),
  GetPage(name: Routes.placeOrderScreen, page: () => const PlaceOrderScreen()),
  GetPage(name: Routes.oTPScreen, page: () => const OTPScreen()),
  GetPage(
      name: Routes.forgotPasswordScreen,
      page: () => const ForgotPasswordScreen()),
  GetPage(
      name: Routes.forgotPasswordOTPScreen,
      page: () => const ForgotPasswordOTPScreen()),
  GetPage(
      name: Routes.newPasswordScreen, page: () => const NewPasswordScreen()),
  GetPage(name: Routes.orderScreen, page: () => const OrderScreen()),
  GetPage(
      name: Routes.orderDetailScreen, page: () => const OrderDetailScreen()),
];
