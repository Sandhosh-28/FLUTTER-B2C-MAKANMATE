import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:makkanmate/Const/colors.dart';

import '../../Const/assets.dart';
import '../../Const/size.dart';
import '../Widget/bottomnavbar.dart';
import 'dashboardcontroller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DashBoardController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(DashBoardController());
    controller.bannerGetAll();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(builder: (logic) {
      if (logic.isLoadings.value == true) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(Assets.logo),
          ),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome To",
                style: TextStyle(
                  fontSize: 15,
                  color: MyColors.textGrey,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Makan Mate",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: MyColors.black,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: MyColors.grey,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none,
                  color: MyColors.grey,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: MyColors.grey,
                )),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              bannerImg(),
              const SizedBox(height: 15),
              GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 15,
                ),
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const UserBottomNavBar(index: 1),
                        ),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset(
                            Assets.food,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: MyColors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Text(
                              "MAKAN MATE",
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: MyColors.whiteTextFormField,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const UserBottomNavBar(index: 2),
                        ),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset(
                            Assets.food,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: MyColors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Text(
                              "MAKAN MART",
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: MyColors.whiteTextFormField,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Text(
              //       "MAKAN MART",
              //       style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 18,
              //       ),
              //     ),
              //     TextButton(
              //         onPressed: () {},
              //         child: const Text(
              //           "See All",
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 18,
              //           ),
              //         ))
              //   ],
              // ),
              // const SizedBox(height: 15),
              // SizedBox(
              //   height: 300,
              //   child: martListView(),
              // ),
              // const SizedBox(height: 15),
              ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: SizedBox(
                      height: 180,
                      child: Image.asset(
                        Assets.adv,
                        fit: BoxFit.fill,
                      ))),
              const SizedBox(height: 15),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Text(
              //       "OUR CATERING MENU",
              //       style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 18,
              //       ),
              //     ),
              //     TextButton(
              //         onPressed: () {},
              //         child: const Text(
              //           "See All",
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 18,
              //           ),
              //         ))
              //   ],
              // ),
              // const SizedBox(height: 15),
              // cateringMenuList(),
              // const SizedBox(height: 15),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Text(
              //       "FEATURED ITEMS",
              //       style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 18,
              //       ),
              //     ),
              //     TextButton(
              //         onPressed: () {},
              //         child: const Text(
              //           "See All",
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 18,
              //           ),
              //         ))
              //   ],
              // ),
              // const SizedBox(height: 15),
              // SizedBox(
              //   height: 300,
              //   child: featuredListView(),
              // ),
            ],
          ),
        ),
      );
    });
  }

  ///BANNER WITH API
  bannerImg() {
    return (controller.bannerImageList.isNotEmpty)
        ? SizedBox(
            height: height(context) / 4,
            width: double.infinity,
            child: CarouselSlider.builder(
              carouselController: controller.carouselController,
              itemCount: controller.bannerImageList.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: SizedBox(
                        width: width(context),
                        child: Image.asset(
                          controller.bannerImageList[index].bannerImageFilePath
                              .toString(),
                          fit: BoxFit.fill,
                        )),
                  ),
                );
              },
              options: CarouselOptions(
                scrollPhysics: const BouncingScrollPhysics(),
                autoPlay: true,
                aspectRatio: 0.6,
                height: double.infinity,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    controller.currentIndex = index;
                  });
                },
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: SizedBox(
                  width: width(context),
                  child: Image.asset(
                    Assets.banner,
                    fit: BoxFit.fill,
                  )),
            ),
          );
  }

  martListView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 180,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        Assets.item,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Daylight Coffee ",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "\$ 8.00",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 15, color: MyColors.black),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        color: MyColors.primaryCustom,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            "4.5",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: MyColors.whiteTextFormField),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "25 min",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15, color: MyColors.black),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  cateringMenuList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: SizedBox(
                          height: 180,
                          child: Image.asset(
                            Assets.banner,
                            fit: BoxFit.fill,
                          ))),
                  const SizedBox(height: 15),
                  const Text(
                    "Food Name",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "\$ 8.00",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15, color: MyColors.black),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 12,
                            color: MyColors.primaryCustom,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Chinese",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 15, color: MyColors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        color: MyColors.primaryCustom,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_rate_rounded,
                                color: MyColors.whiteTextFormField,
                                size: 18,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "4.5",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.whiteTextFormField),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "25 min",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15, color: MyColors.black),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  featuredListView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 180,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        Assets.item,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Daylight Coffee ",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "\$ 8.00",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 15, color: MyColors.black),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        color: MyColors.primaryCustom,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            "4.5",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: MyColors.whiteTextFormField),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "25 min",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15, color: MyColors.black),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
