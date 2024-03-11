import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makkanmate/Const/colors.dart';
import 'package:makkanmate/Const/size.dart';
import 'package:makkanmate/Screens/Category/ProductDetail/productedtailcontroller.dart';
import 'package:makkanmate/Screens/Widget/submitbutton.dart';

import '../../../Const/approute.dart';
import '../../../Const/assets.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late ProductDetailController controller;

  String? productCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(ProductDetailController());
    productCode = Get.arguments as String;
    print("<<<<<<<<<<<$productCode>>>>>>>>>>");
    controller.productGetByCode(productCode);
  }

  ///INCREMENT - DECREMENT FUNCTION

  int counter = 1;

  void increment() {
    setState(() {
      counter++;
    });
  }

  void decrement() {
    setState(() {
      if (counter > 0) {
        counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailController>(builder: (logic) {
      if (logic.isLoading.value == true) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      return Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                ),
                title: const Text("Product Detail"),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    Assets.banner,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 80,
                        child: productGalleryListView(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    controller.productList.first.productName ??
                                        "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                ElevatedButton(
                                    onPressed: () {},
                                    child: const Text("Review"))
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Shortbread, chocolate turtle cookies, and red velvet. 8 ounces cream cheese, softened."
                              "Shortbread, chocolate turtle cookies, and red velvet. 8 ounces cream cheese, softened.",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16.0,
                                color: MyColors.textGrey,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Flexible(
                                  child: Text(
                                    "Add's On",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Card(
                                  elevation: 0,
                                  color: MyColors.lightOrange,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 8),
                                    child: Text(
                                      "Required".toUpperCase(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.orange,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Obx(() {
                              return choiceListView();
                            }),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Flexible(
                                  child: Text(
                                    "Choice of Bottom Cookie",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Card(
                                  elevation: 0,
                                  color: MyColors.lightOrange,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 8),
                                    child: Text(
                                      "Required".toUpperCase(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.orange,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            bottomChoiceListView(),
                            const SizedBox(height: 10),
                            ListTile(
                              onTap: () {},
                              leading: const Text(
                                "Add Special Instructions",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.0,
                                ),
                              ),
                              trailing:
                                  const Icon(Icons.arrow_forward_ios_outlined),
                            ),
                            const Divider(thickness: 1),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (counter > 1) {
                                      setState(() {
                                        decrement();
                                      });
                                    }
                                  },
                                  icon: Image.asset(Assets.minusButton),
                                  iconSize: 50,
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width: width(context) / 8,
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    initialValue: '$counter',
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.all(8.0)),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      increment();
                                    });
                                  },
                                  icon: Image.asset(Assets.plusButton),
                                  iconSize: 50,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SubmitButton(
                                isLoading: false,
                                onTap: () {
                                  Get.toNamed(Routes.placeOrderScreen);
                                },
                                title: "ADD"),
                            const SizedBox(height: 20),
                            const Text(
                              "Featured Items",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 250,
                              child: featuredListView(),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Most Popular",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 250,
                              child: mostPopularListView(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  ///PRODUCT GALLERY IMAGES LISTVIEW
  productGalleryListView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: SizedBox(
                  width: 80,
                  child: Image.asset(
                    Assets.food,
                    fit: BoxFit.fill,
                  )),
            ),
          );
        });
  }

  ///TOP CHOICES LISTVIEW

  List choiceName = [
    "Chocolate Chip",
    "Cookies and Cream",
    "Funfetti",
    "Peanut Butter",
  ];

  choiceListView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.productList.first.masterCustomAddOn?.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                children: [
                  // Radio<String>(
                  //   value: choiceName[index],
                  //   groupValue: controller.topChoiceRadio,
                  //   onChanged: (String? value) {
                  //     setState(() {
                  //       controller.topChoiceRadio = value;
                  //     });
                  //   },
                  // ),
                  Text(
                    controller.productList.first.masterCustomAddOn?[index]
                            .productId ??
                        "",
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: MyColors.textGrey,
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 1)
            ],
          );
        });
  }

  ///BOTTOM CHOICES LISTVIEW

  List bottomChoiceName = [
    "Chocolate Chip",
    "Cookies and Cream",
    "Funfetti",
    "Peanut Butter",
  ];

  bottomChoiceListView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: choiceName.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: choiceName[index],
                    groupValue: controller.bottomChoiceRadio,
                    onChanged: (String? value) {
                      setState(() {
                        controller.bottomChoiceRadio = value;
                      });
                    },
                  ),
                  Text(
                    choiceName[index],
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: MyColors.textGrey,
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 1)
            ],
          );
        });
  }

  ///FEATURED ITEMS LISTVIEW

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
                        Assets.food3,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Chow Fun",
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "\$ 8.00",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 15, color: MyColors.black),
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            "Chinese",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 15, color: MyColors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///MOST POPULAR

  mostPopularListView() {
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
                    "Cookie Sandwich",
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "\$ 8.00",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 15, color: MyColors.black),
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            "Chinese",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 15, color: MyColors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
