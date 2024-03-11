import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:makkanmate/Const/colors.dart';
import 'package:makkanmate/Const/size.dart';
import 'package:makkanmate/Screens/Category/ProductListing/productlistingcontroller.dart';

import '../../../Const/approute.dart';
import '../../../Const/assets.dart';
import '../../../ModelClass/categorymodel.dart';
import '../../Widget/constructor.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  late ProductListingController controller;

  // late CategoryModel? categoryModel = CategoryModel();

  String? categoryCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(ProductListingController());
    categoryCode = Get.arguments as String;
    controller.getAllSubCategoryList(categoryCode);

    print(">>>>>>>>>>>><<<<<<<<<<<<<<<<<<");
    print(categoryCode);
    print(">>>>>>>>>>>><<<<<<<<<<<<<<<<<<");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductListingController>(builder: (logic) {
      if (logic.isLoading.value == true) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return (controller.productList.isNotEmpty)
          ? Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_outlined)),
                title: const Text("Category"),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(18.0),
                physics: const ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "BENTO SET",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                      return (controller.subCategoryList.value != null)
                          ? SizedBox(
                              height: 50,
                              child: subCategoryList(),
                            )
                          : const SizedBox();
                    }),
                    (controller.subCategoryList.value != null)
                        ? const SizedBox(height: 20)
                        : const SizedBox(),
                    Obx(() {
                      return categoryProductGridView();
                    }),
                  ],
                ),
              ),
            )
          : Scaffold(
              body: Center(
                child: Image.asset(Assets.noImage),
              ),
            );
    });
  }

  ///PRODUCT LISTING LISTVIEW & GRIDVIEW BUILDER

  int selectedListIndex = 0;

  subCategoryList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.subCategoryList.value?.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              setState(() {
                selectedListIndex = index;
              });
              await controller.getProductByCategoryId(
                  categoryId: categoryCode ?? '',
                  subCategoryId:
                      controller.subCategoryList.value?[index].code ?? '',
                  isPagination: false,
                  subCategoryL2Name: '');
              print("...................");
              print(controller.subCategoryList.value?[index].code);
            },
            child: Card(
              color: selectedListIndex == index
                  ? MyColors.primaryCustom
                  : MyColors.whiteTextFormField,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  // searchLists[index].text.toUpperCase(),
                  controller.subCategoryList.value?[index].name ?? " ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: selectedListIndex == index
                        ? MyColors.whiteTextFormField
                        : MyColors.grey,
                  ),
                ),
              ),
            ),
          );
        });
  }

  categoryProductGridView() {
    if (controller.productList.isNotEmpty) {
      return GridView.builder(
          shrinkWrap: true,
          itemCount: controller.productList.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 300,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(Routes.productDetailScreen,
                    arguments: controller.productList[index].productCode);
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    height: 300,
                    width: 300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: controller.productList[index].productImagePath !=
                              null
                          ? Image.network(
                              controller.productList[index].productImagePath ??
                                  "https://images.pexels.com/photos/327158/pexels-photo-327158.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                              fit: BoxFit.fill,
                            )
                          : Image.asset(
                              Assets.food1,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  Assets.mins,
                                  scale: 2,
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  "25 Mins",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.whiteTextFormField,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  Assets.doller,
                                  scale: 3,
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  "2590",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.whiteTextFormField,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const Card(
                          color: MyColors.primaryCustom,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Text(
                              "49.5",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: MyColors.whiteTextFormField,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          });
    }
  }
}
