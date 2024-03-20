import 'package:get/get.dart';

import '../../../Helper/api.dart';
import '../../../Helper/networkclass.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../ModelClass/getfavproductlistmodel.dart';
import '../../../ModelClass/productmodel.dart';
import '../../../ModelClass/subcategorymodel.dart';
import '../../../locator/cart_service.dart';
import '../../../locator/locator.dart';

class ProductListingController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;

  Rx<List<SubCategoryModel>?> subCategoryList =
      (null as List<SubCategoryModel>?).obs;

  RxList<ProductModel> productList = <ProductModel>[].obs;

  List<GetFavProductListModel> favProductList = [];


  final CartService cartService = getIt<CartService>();


  String categoryName = "";
  int currentPage = 1;
  int totalPages = 1;

  ///GET ALL SUBCATEGORY
  getAllSubCategoryList(String? categoryCode) async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await getProductByCategoryId(
        categoryId: categoryCode ?? '',
        subCategoryId: '',
        isPagination: false,
        subCategoryL2Name: "");
    change(null, status: RxStatus.loading());
    await NetworkManager.get(url: HttpUrl.getAllSubCategory, parameters: {
      "OrganizationId": HttpUrl.org,
      "CategoryCode": categoryCode
    }).then((response) {
      isLoading.value = false;
      print(categoryCode);
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            List<SubCategoryModel> list =
                resJson.map<SubCategoryModel>((value) {
              return SubCategoryModel.fromJson(value);
            }).toList();
            list.insert(0, SubCategoryModel(name: "All"));
            subCategoryList.value = list;
            categoryName =
                subCategoryList.value?.first.categoryName ?? "Sub Categories";
            change(null, status: RxStatus.success());
            return;
          }
        } else {
          subCategoryList.value = null;
          change(null, status: RxStatus.error());
          PreferenceHelper.getShowSnackBar(
              context: Get.context!,
              msg: response.apiResponseModel?.message ?? '');
        }
      } else {
        change(null, status: RxStatus.error());
        PreferenceHelper.getShowSnackBar(
            msg: "There is no Subcategory", context: Get.context);
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());
      PreferenceHelper.getShowSnackBar(
          context: Get.context!, msg: error.toString());
    });
    // Similar usage for POST, PUT, and DELETE requests
  }

  // ///PRODUCT COUNT UPDATE
  // Future<void> updateProductCount() async {
  //   for (var product in productList) {
  //     cartService.cartItems.firstWhereOrNull((element) {
  //       if (element.productCode == product.productCode) {
  //         product.qtycount = element.qtycount;
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     });
  //   }
  // }

  ///GET PRODUCT BY ID
  Future<void> getProductByCategoryId({
    required String categoryId,
    required String subCategoryId,
    required String subCategoryL2Name,
    required bool isPagination,
  }) async {
    ///FAVORITE PRODUCT GET
    // await GetFavProduct();
    change(null, status: RxStatus.loadingMore());
    await NetworkManager.get(
      url: HttpUrl.getAllProduct,
      parameters: {
        "OrganizationId": HttpUrl.org,
        "Category": categoryId ?? "",
        "SubCategory": (subCategoryId.isNotEmpty) ? subCategoryId : "",
        "SubCategoryL2": "",
        "pageNo": "$currentPage",
        "pageSize": "10"
      },
    ).then((response) {
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.result != null) {
          List? resJson = response.apiResponseModel!.result!;
          if (resJson != null) {
            List<ProductModel> list;
            if (favProductList.length != 0) {
              print("++++++++++++++++++++++++++++++1111111");
              list = resJson.map<ProductModel>((value) {
                ProductModel _model = ProductModel.fromJson(value);
                _model.isFavourite = favProductList.any(
                    (element) => element.productCode == _model.productCode);
                return _model;
                // return ProductModel.fromJson(value);
              }).toList();
            } else {
              print("++++++++++++++++++++++++++++++22222222");
              list = resJson.map<ProductModel>((value) {
                return ProductModel.fromJson(value);
              }).toList();
            }
            if (!isPagination) {
              productList.clear();
            }
            productList.value.addAll(list);
            print("productList.length");
            print(productList.length);
            totalPages = response.apiResponseModel?.totalNumberOfPages ?? 1;
            currentPage++;
            // updateProductCount();
            change(productList);
          } else {
            productList.value = [];
          }
          change(null, status: RxStatus.success());
        } else {
          productList.value = [];
          currentPage = 1;
          print("productList.length");
          print(productList.length);
          change(null, status: RxStatus.error());
        }
      } else {
        productList.value = [];
        currentPage = 1;
        change(null, status: RxStatus.error());
        String? message = response.apiResponseModel?.message;
        PreferenceHelper.getShowSnackBar(context: Get.context!, msg: message);
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());

      PreferenceHelper.getShowSnackBar(
          context: Get.context!, msg: error.toString());
    });
  }

  Future<void> updateProductCount() async {
    for (var product in productList) {
      cartService.cartItems.firstWhereOrNull((element) {
        if (element.productCode == product.productCode) {
          product.qtyCount = element.qtyCount;
          return true;
        } else {
          return false;
        }
      });
    }
  }


}
