import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:makkanmate/Const/colors.dart';

import '../../Const/approute.dart';
import '../../Const/assets.dart';
import 'categorycontroller.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late CategoryListController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(CategoryListController());
    controller.getAllCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryListController>(builder: (logic) {
      if (logic.isLoadings.value == true) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.offAllNamed(Routes.userBottomNavBar);
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
          title: const Text("Category"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Top Categories Menu",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              categoryList(),
            ],
          ),
        ),
      );
    });
  }

  categoryList() {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.categoryList.value?.length,
        // controller.categoryList.value?.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 15.0,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(Routes.productListingScreen,
                  arguments: controller.categoryList.value?[index].code ?? "");
              print("<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>");
              print(controller.categoryList.value?[index].code);
            },
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child:
                      // Image.asset(
                      //   Assets.food,
                      //   fit: BoxFit.fill,
                      // ),

                      ///Dynamic Changes
                      (controller.categoryList.value?[index]
                                  .iconImageFilePath !=
                              null)
                          ? ("${controller.categoryList.value?[index].iconImageFilePath}"
                                  .isNotEmpty)
                              ? Image.network(
                                  alignment: Alignment.center,
                                  controller.categoryList.value?[index]
                                          .iconImageFilePath ??
                                      "",
                                  fit: BoxFit.fill,
                                )
                              : Image.asset(
                                  Assets.food,
                                  fit: BoxFit.fill,
                                )
                          : const Icon(Icons.error),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: MyColors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      controller.categoryList.value?[index].name ?? "",
                      // "Korean",
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: MyColors.whiteTextFormField,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
