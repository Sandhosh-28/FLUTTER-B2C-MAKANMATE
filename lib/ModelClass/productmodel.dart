class ProductModel {
  ProductModel({
    this.productName,
    this.orgId,
    this.branchCode,
    this.code,
    this.name,
    this.productCode,
    this.specification,
    this.category,
    this.subCategory,
    this.categoryName,
    this.categoryShortUrl,
    this.subCategoryName,
    this.subCategoryShortUrl,
    this.uom,
    this.uomName,
    this.pcsPerCarton,
    this.productType,
    this.brand,
    this.weight,
    this.unitCost,
    this.averageCost,
    this.pcsPrice,
    this.cartonPrice,
    this.barCode,
    this.displayOrder,
    this.isActive,
    this.isStock,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.sellingCost,
    this.sellingBoxCost,
    this.stockQty,
    this.stockBoxQty,
    this.stockPcsQty,
    this.salesAccount,
    this.inventoryAccount,
    this.cOGAccount,
    this.productImageString,
    this.productImage,
    this.createdOnString,
    this.changedOnString,
    this.supplierCode,
    this.supplierName,
    this.taxPerc,
    this.productBarcode,
    this.boxCount,
    this.productImgBase64String,
    this.productImageFileName,
    this.productImagePath,
    this.minSellingCost,
    this.minSellingBoxCost,
    this.tag,
    this.isWeight,
    this.uomPriceDetail,
    this.stockWQty,
    this.unitMarginPerc,
    this.boxMarginPerc,
    this.haveTransaction,
    this.ecommerceDetail,
    this.ecommerceGalleryImages,
    this.haveBatch,
    this.haveSerialNo,
    this.haveExpiryDate,
    this.haveMfDate,
    this.pOSMinSellingPrice,
    this.pOSSellingPrice,
    this.publishToPos,
    this.isOpenItem,
    this.taxCode,
    this.taxType,
    this.unitPrice,
    this.qty,
    this.branchPrice,
    this.productshorturl,
    this.subCategoryL2Code,
    this.touchCategoryCode,
    this.touchCategoryName,
    this.subCategoryL2Name,
    this.subcategoryL2ShortUrl,
    this.isTouchPad,
    this.productTags,
    this.relatedProductInfo,
    this.masterCustomAddOn,
    this.productTagHeaderInfo,
  });

  ProductModel.fromJson(dynamic json, {bool forSharedPreference = false}) {
    productName = json['ProductName'];
    orgId = json['OrgId'];
    branchCode = json['BranchCode'];
    code = json['Code'];
    name = json['Name'];
    productCode = json['ProductCode'];
    specification = json['Specification'];
    category = json['Category'];
    subCategory = json['SubCategory'];
    categoryName = json['CategoryName'];
    categoryShortUrl = json['CategoryShortUrl'];
    subCategoryName = json['SubCategoryName'];
    subCategoryShortUrl = json['SubCategoryShortUrl'];
    uom = json['Uom'];
    uomName = json['UomName'];
    pcsPerCarton = json['PcsPerCarton'];
    productType = json['ProductType'];
    brand = json['Brand'];
    weight = json['Weight'];
    unitCost = json['UnitCost'];
    averageCost = json['AverageCost'];
    pcsPrice = json['PcsPrice'];
    cartonPrice = json['CartonPrice'];
    barCode = json['BarCode'];
    displayOrder = json['DisplayOrder'];
    isActive = json['IsActive'];
    isStock = json['IsStock'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    sellingCost = json['SellingCost'];
    sellingBoxCost = json['SellingBoxCost'];
    stockQty = json['StockQty'];
    stockBoxQty = json['StockBoxQty'];
    stockPcsQty = json['StockPcsQty'];
    salesAccount = json['SalesAccount'];
    inventoryAccount = json['InventoryAccount'];
    cOGAccount = json['COGAccount'];
    productImageString = json['ProductImageString'];
    productImage = json['ProductImage'];
    createdOnString = json['CreatedOnString'];
    changedOnString = json['ChangedOnString'];
    supplierCode = json['SupplierCode'];
    supplierName = json['SupplierName'];
    taxPerc = json['TaxPerc'];
    if (json['ProductBarcode'] != null) {
      productBarcode = [];
      json['ProductBarcode'].forEach((v) {
        productBarcode?.add(ProductBarcode.fromJson(v));
      });
    }
    boxCount = json['BoxCount'];
    productImgBase64String = json['ProductImg_Base64String'];
    productImageFileName = json['ProductImageFileName'];
    productImagePath = json['ProductImagePath'];
    minSellingCost = json['MinSellingCost'];
    minSellingBoxCost = json['MinSellingBoxCost'];
    tag = json['Tag'];
    isWeight = json['IsWeight'];
    if (json['UomPriceDetail'] != null) {
      uomPriceDetail = [];
      json['UomPriceDetail'].forEach((v) {
        uomPriceDetail?.add(UomPriceDetail.fromJson(v));
      });
    }
    stockWQty = json['StockWQty'];
    unitMarginPerc = json['UnitMarginPerc'];
    boxMarginPerc = json['BoxMarginPerc'];
    haveTransaction = json['HaveTransaction'];
    if (json['EcommerceDetail'] != null) {
      ecommerceDetail = [];
      json['EcommerceDetail'].forEach((v) {
        ecommerceDetail?.add(EcommerceDetail.fromJson(v));
      });
    }
    if (json['EcommerceGalleryImages'] != null) {
      ecommerceGalleryImages = [];
      json['EcommerceGalleryImages'].forEach((v) {
        ecommerceGalleryImages?.add(EcommerceGalleryImages.fromJson(v));
      });
    }
    haveBatch = json['HaveBatch'];
    haveSerialNo = json['HaveSerialNo'];
    haveExpiryDate = json['HaveExpiryDate'];
    haveMfDate = json['HaveMfDate'];
    pOSMinSellingPrice = json['POSMinSellingPrice'];
    pOSSellingPrice = json['POSSellingPrice'];
    publishToPos = json['PublishToPos'];
    isOpenItem = json['IsOpenItem'];
    taxCode = json['TaxCode'];
    taxType = json['TaxType'];
    unitPrice = json['UnitPrice'];
    qty = json['Qty'];
    if (json['BranchPrice'] != null) {
      branchPrice = [];
      json['BranchPrice'].forEach((v) {
        branchPrice?.add(BranchPrice.fromJson(v));
      });
    }
    productshorturl = json['productshorturl'];
    subCategoryL2Code = json['SubCategoryL2Code'];
    touchCategoryCode = json['TouchCategoryCode'];
    touchCategoryName = json['TouchCategoryName'];
    subCategoryL2Name = json['SubCategoryL2Name'];
    subcategoryL2ShortUrl = json['SubcategoryL2ShortUrl'];
    isTouchPad = json['IsTouchPad'];
    if (json['ProductTags'] != null) {
      productTags = [];
      json['ProductTags'].forEach((v) {
        productTags?.add(ProductTags.fromJson(v));
      });
    }
    if (json['RelatedProductInfo'] != null) {
      relatedProductInfo = [];
      json['RelatedProductInfo'].forEach((v) {
        relatedProductInfo?.add(RelatedProductInfo.fromJson(v));
      });
    }
    if (json['MasterCustomAddOn'] != null) {
      masterCustomAddOn = [];
      json['MasterCustomAddOn'].forEach((v) {
        masterCustomAddOn?.add(MasterCustomAddOn.fromJson(v));
      });
    }
    if (json['ProductTagHeaderInfo'] != null) {
      productTagHeaderInfo = [];
      json['ProductTagHeaderInfo'].forEach((v) {
        productTagHeaderInfo?.add(ProductTagHeaderInfo.fromJson(v));
      });
    }
    if (forSharedPreference == true) {
      qtyCount = json['qtycount'] as int? ?? 0;
    }
  }
  String? productName;
  int? orgId;
  String? branchCode;
  String? code;
  String? name;
  String? productCode;
  String? specification;
  String? category;
  String? subCategory;
  String? categoryName;
  String? categoryShortUrl;
  String? subCategoryName;
  String? subCategoryShortUrl;
  String? uom;
  String? uomName;
  int? pcsPerCarton;
  String? productType;
  String? brand;
  double? weight;
  double? unitCost;
  double? averageCost;
  double? pcsPrice;
  double? cartonPrice;
  String? barCode;
  int? displayOrder;
  bool? isActive;
  bool? isStock;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  double? sellingCost;
  double? sellingBoxCost;
  double? stockQty;
  double? stockBoxQty;
  double? stockPcsQty;
  String? salesAccount;
  String? inventoryAccount;
  String? cOGAccount;
  String? productImageString;
  String? productImage;
  String? createdOnString;
  String? changedOnString;
  String? supplierCode;
  String? supplierName;
  double? taxPerc;
  List<ProductBarcode>? productBarcode;
  int? boxCount;
  String? productImgBase64String;
  String? productImageFileName;
  String? productImagePath;
  double? minSellingCost;
  double? minSellingBoxCost;
  String? tag;
  bool? isWeight;
  List<UomPriceDetail>? uomPriceDetail;
  double? stockWQty;
  double? unitMarginPerc;
  double? boxMarginPerc;
  bool? haveTransaction;
  List<EcommerceDetail>? ecommerceDetail;
  List<EcommerceGalleryImages>? ecommerceGalleryImages;
  bool? haveBatch;
  bool? haveSerialNo;
  bool? haveExpiryDate;
  bool? haveMfDate;
  double? pOSMinSellingPrice;
  double? pOSSellingPrice;
  bool? publishToPos;
  bool? isOpenItem;
  double? taxCode;
  String? taxType;
  double? unitPrice;
  double? qty;
  List<BranchPrice>? branchPrice;
  String? productshorturl;
  String? subCategoryL2Code;
  String? touchCategoryCode;
  String? touchCategoryName;
  String? subCategoryL2Name;
  String? subcategoryL2ShortUrl;
  bool? isTouchPad;
  List<ProductTags>? productTags;
  List<RelatedProductInfo>? relatedProductInfo;
  List<MasterCustomAddOn>? masterCustomAddOn;
  List<ProductTagHeaderInfo>? productTagHeaderInfo;

  bool isFavourite = false;

  int qtyCount = 0;

  increment() {
    qtyCount++;
  }

  decrement() {
    if (qtyCount > 0) {
      qtyCount--;
    }
  }

  Map<String, dynamic> toJson({bool forSharedPreference = false}) {
    final map = <String, dynamic>{};
    map['ProductName'] = productName;
    map['OrgId'] = orgId;
    map['BranchCode'] = branchCode;
    map['Code'] = code;
    map['Name'] = name;
    map['ProductCode'] = productCode;
    map['Specification'] = specification;
    map['Category'] = category;
    map['SubCategory'] = subCategory;
    map['CategoryName'] = categoryName;
    map['CategoryShortUrl'] = categoryShortUrl;
    map['SubCategoryName'] = subCategoryName;
    map['SubCategoryShortUrl'] = subCategoryShortUrl;
    map['Uom'] = uom;
    map['UomName'] = uomName;
    map['PcsPerCarton'] = pcsPerCarton;
    map['ProductType'] = productType;
    map['Brand'] = brand;
    map['Weight'] = weight;
    map['UnitCost'] = unitCost;
    map['AverageCost'] = averageCost;
    map['PcsPrice'] = pcsPrice;
    map['CartonPrice'] = cartonPrice;
    map['BarCode'] = barCode;
    map['DisplayOrder'] = displayOrder;
    map['IsActive'] = isActive;
    map['IsStock'] = isStock;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['SellingCost'] = sellingCost;
    map['SellingBoxCost'] = sellingBoxCost;
    map['StockQty'] = stockQty;
    map['StockBoxQty'] = stockBoxQty;
    map['StockPcsQty'] = stockPcsQty;
    map['SalesAccount'] = salesAccount;
    map['InventoryAccount'] = inventoryAccount;
    map['COGAccount'] = cOGAccount;
    map['ProductImageString'] = productImageString;
    map['ProductImage'] = productImage;
    map['CreatedOnString'] = createdOnString;
    map['ChangedOnString'] = changedOnString;
    map['SupplierCode'] = supplierCode;
    map['SupplierName'] = supplierName;
    map['TaxPerc'] = taxPerc;
    if (productBarcode != null) {
      map['ProductBarcode'] = productBarcode?.map((v) => v.toJson()).toList();
    }
    map['BoxCount'] = boxCount;
    map['ProductImg_Base64String'] = productImgBase64String;
    map['ProductImageFileName'] = productImageFileName;
    map['ProductImagePath'] = productImagePath;
    map['MinSellingCost'] = minSellingCost;
    map['MinSellingBoxCost'] = minSellingBoxCost;
    map['Tag'] = tag;
    map['IsWeight'] = isWeight;
    if (uomPriceDetail != null) {
      map['UomPriceDetail'] = uomPriceDetail?.map((v) => v.toJson()).toList();
    }
    map['StockWQty'] = stockWQty;
    map['UnitMarginPerc'] = unitMarginPerc;
    map['BoxMarginPerc'] = boxMarginPerc;
    map['HaveTransaction'] = haveTransaction;
    if (ecommerceDetail != null) {
      map['EcommerceDetail'] = ecommerceDetail?.map((v) => v.toJson()).toList();
    }
    if (ecommerceGalleryImages != null) {
      map['EcommerceGalleryImages'] =
          ecommerceGalleryImages?.map((v) => v.toJson()).toList();
    }
    map['HaveBatch'] = haveBatch;
    map['HaveSerialNo'] = haveSerialNo;
    map['HaveExpiryDate'] = haveExpiryDate;
    map['HaveMfDate'] = haveMfDate;
    map['POSMinSellingPrice'] = pOSMinSellingPrice;
    map['POSSellingPrice'] = pOSSellingPrice;
    map['PublishToPos'] = publishToPos;
    map['IsOpenItem'] = isOpenItem;
    map['TaxCode'] = taxCode;
    map['TaxType'] = taxType;
    map['UnitPrice'] = unitPrice;
    map['Qty'] = qty;
    if (branchPrice != null) {
      map['BranchPrice'] = branchPrice?.map((v) => v.toJson()).toList();
    }
    map['productshorturl'] = productshorturl;
    map['SubCategoryL2Code'] = subCategoryL2Code;
    map['TouchCategoryCode'] = touchCategoryCode;
    map['TouchCategoryName'] = touchCategoryName;
    map['SubCategoryL2Name'] = subCategoryL2Name;
    map['SubcategoryL2ShortUrl'] = subcategoryL2ShortUrl;
    map['IsTouchPad'] = isTouchPad;
    if (productTags != null) {
      map['ProductTags'] = productTags?.map((v) => v.toJson()).toList();
    }
    if (relatedProductInfo != null) {
      map['RelatedProductInfo'] =
          relatedProductInfo?.map((v) => v.toJson()).toList();
    }
    if (masterCustomAddOn != null) {
      map['MasterCustomAddOn'] =
          masterCustomAddOn?.map((v) => v.toJson()).toList();
    }
    if (productTagHeaderInfo != null) {
      map['ProductTagHeaderInfo'] =
          productTagHeaderInfo?.map((v) => v.toJson()).toList();
    }
    if (forSharedPreference == true) {
      map['qtycount'] = qtyCount;
    }
    return map;
  }
}

class ProductTagHeaderInfo {
  ProductTagHeaderInfo({
    this.orgId,
    this.productCode,
    this.tagCode,
    this.detailTagCode,
    this.tagDescription,
    this.tagDetailDescription,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
  });

  ProductTagHeaderInfo.fromJson(dynamic json) {
    orgId = json['OrgId'];
    productCode = json['ProductCode'];
    tagCode = json['TagCode'];
    detailTagCode = json['DetailTagCode'];
    tagDescription = json['TagDescription'];
    tagDetailDescription = json['TagDetailDescription'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
  }
  int? orgId;
  String? productCode;
  String? tagCode;
  String? detailTagCode;
  String? tagDescription;
  String? tagDetailDescription;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['ProductCode'] = productCode;
    map['TagCode'] = tagCode;
    map['DetailTagCode'] = detailTagCode;
    map['TagDescription'] = tagDescription;
    map['TagDetailDescription'] = tagDetailDescription;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    return map;
  }
}

class MasterCustomAddOn {
  MasterCustomAddOn({
    this.orgId,
    this.productId,
    this.customAddOnCode,
    this.createdBy,
    this.createdOn,
  });

  MasterCustomAddOn.fromJson(dynamic json) {
    orgId = json['OrgId'];
    productId = json['ProductId'];
    customAddOnCode = json['CustomAddOnCode'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
  }
  int? orgId;
  String? productId;
  String? customAddOnCode;
  String? createdBy;
  String? createdOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['ProductId'] = productId;
    map['CustomAddOnCode'] = customAddOnCode;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    return map;
  }
}

class RelatedProductInfo {
  RelatedProductInfo({
    this.orgId,
    this.productCode,
    this.relatedProductCode,
    this.relatedProductName,
    this.sellingCost,
    this.imageFileName,
    this.imageFilePath,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
  });

  RelatedProductInfo.fromJson(dynamic json) {
    orgId = json['OrgId'];
    productCode = json['ProductCode'];
    relatedProductCode = json['RelatedProductCode'];
    relatedProductName = json['RelatedProductName'];
    sellingCost = json['SellingCost'];
    imageFileName = json['ImageFileName'];
    imageFilePath = json['ImageFilePath'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
  }
  int? orgId;
  String? productCode;
  String? relatedProductCode;
  String? relatedProductName;
  double? sellingCost;
  String? imageFileName;
  String? imageFilePath;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['ProductCode'] = productCode;
    map['RelatedProductCode'] = relatedProductCode;
    map['RelatedProductName'] = relatedProductName;
    map['SellingCost'] = sellingCost;
    map['ImageFileName'] = imageFileName;
    map['ImageFilePath'] = imageFilePath;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    return map;
  }
}

class ProductTags {
  ProductTags({
    this.orgId,
    this.productCode,
    this.productName,
    this.tagCode,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
  });

  ProductTags.fromJson(dynamic json) {
    orgId = json['OrgId'];
    productCode = json['ProductCode'];
    productName = json['ProductName'];
    tagCode = json['TagCode'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
  }
  int? orgId;
  String? productCode;
  String? productName;
  String? tagCode;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['ProductCode'] = productCode;
    map['ProductName'] = productName;
    map['TagCode'] = tagCode;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    return map;
  }
}

class BranchPrice {
  BranchPrice({
    this.orgId,
    this.productCode,
    this.branchCode,
    this.retailPrice,
    this.minRetailPrice,
  });

  BranchPrice.fromJson(dynamic json) {
    orgId = json['OrgId'];
    productCode = json['ProductCode'];
    branchCode = json['BranchCode'];
    retailPrice = json['RetailPrice'];
    minRetailPrice = json['MinRetailPrice'];
  }
  int? orgId;
  String? productCode;
  String? branchCode;
  double? retailPrice;
  double? minRetailPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['ProductCode'] = productCode;
    map['BranchCode'] = branchCode;
    map['RetailPrice'] = retailPrice;
    map['MinRetailPrice'] = minRetailPrice;
    return map;
  }
}

class EcommerceGalleryImages {
  EcommerceGalleryImages({
    this.orgId,
    this.productCode,
    this.slNo,
    this.imageFileName,
    this.imageFilePath,
    this.createdBy,
    this.createdOn,
    this.galleryImgBase64String,
    this.galleryImage,
  });

  EcommerceGalleryImages.fromJson(dynamic json) {
    orgId = json['OrgId'];
    productCode = json['ProductCode'];
    slNo = json['SlNo'];
    imageFileName = json['ImageFileName'];
    imageFilePath = json['ImageFilePath'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    galleryImgBase64String = json['GalleryImg_Base64String'];
    galleryImage = json['GalleryImage'];
  }
  int? orgId;
  String? productCode;
  int? slNo;
  String? imageFileName;
  String? imageFilePath;
  String? createdBy;
  String? createdOn;
  String? galleryImgBase64String;
  String? galleryImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['ProductCode'] = productCode;
    map['SlNo'] = slNo;
    map['ImageFileName'] = imageFileName;
    map['ImageFilePath'] = imageFilePath;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['GalleryImg_Base64String'] = galleryImgBase64String;
    map['GalleryImage'] = galleryImage;
    return map;
  }
}

class EcommerceDetail {
  EcommerceDetail({
    this.orgId,
    this.productCode,
    this.desciption,
    this.specification,
    this.sellingPrice,
    this.sEOMetaTitle,
    this.sEOMetaKeyword,
    this.sEOMetaDescription,
    this.publishOnWeb,
    this.stockAvailability,
    this.qtyOnHand,
    this.createdBy,
    this.createdOn,
    this.surcharge,
    this.stockStatus,
    this.branch,
    this.selectedAddons,
    this.videoProvider,
    this.videoLink,
    this.haveAddon,
  });

  EcommerceDetail.fromJson(dynamic json) {
    orgId = json['OrgId'];
    productCode = json['ProductCode'];
    desciption = json['Desciption'];
    specification = json['Specification'];
    sellingPrice = json['SellingPrice'];
    sEOMetaTitle = json['SEOMetaTitle'];
    sEOMetaKeyword = json['SEOMetaKeyword'];
    sEOMetaDescription = json['SEOMetaDescription'];
    publishOnWeb = json['PublishOnWeb'];
    stockAvailability = json['StockAvailability'];
    qtyOnHand = json['QtyOnHand'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    surcharge = json['Surcharge'];
    stockStatus = json['StockStatus'];
    branch = json['Branch'];
    selectedAddons = json['SelectedAddons'];
    videoProvider = json['VideoProvider'];
    videoLink = json['VideoLink'];
    haveAddon = json['HaveAddon'];
  }
  int? orgId;
  String? productCode;
  String? desciption;
  String? specification;
  double? sellingPrice;
  String? sEOMetaTitle;
  String? sEOMetaKeyword;
  String? sEOMetaDescription;
  bool? publishOnWeb;
  bool? stockAvailability;
  int? qtyOnHand;
  String? createdBy;
  String? createdOn;
  int? surcharge;
  String? stockStatus;
  String? branch;
  String? selectedAddons;
  String? videoProvider;
  String? videoLink;
  bool? haveAddon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['ProductCode'] = productCode;
    map['Desciption'] = desciption;
    map['Specification'] = specification;
    map['SellingPrice'] = sellingPrice;
    map['SEOMetaTitle'] = sEOMetaTitle;
    map['SEOMetaKeyword'] = sEOMetaKeyword;
    map['SEOMetaDescription'] = sEOMetaDescription;
    map['PublishOnWeb'] = publishOnWeb;
    map['StockAvailability'] = stockAvailability;
    map['QtyOnHand'] = qtyOnHand;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['Surcharge'] = surcharge;
    map['StockStatus'] = stockStatus;
    map['Branch'] = branch;
    map['SelectedAddons'] = selectedAddons;
    map['VideoProvider'] = videoProvider;
    map['VideoLink'] = videoLink;
    map['HaveAddon'] = haveAddon;
    return map;
  }
}

class UomPriceDetail {
  UomPriceDetail({
    this.orgId,
    this.productCode,
    this.code,
    this.qty,
    this.price,
    this.isActive,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
  });

  UomPriceDetail.fromJson(dynamic json) {
    orgId = json['OrgId'];
    productCode = json['ProductCode'];
    code = json['Code'];
    qty = json['Qty'];
    price = json['Price'];
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
  }
  int? orgId;
  String? productCode;
  String? code;
  int? qty;
  double? price;
  bool? isActive;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['ProductCode'] = productCode;
    map['Code'] = code;
    map['Qty'] = qty;
    map['Price'] = price;
    map['IsActive'] = isActive;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    return map;
  }
}

class ProductBarcode {
  ProductBarcode({
    this.orgId,
    this.productCode,
    this.productName,
    this.barcode,
    this.cartonPrice,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
  });

  ProductBarcode.fromJson(dynamic json) {
    orgId = json['OrgId'];
    productCode = json['ProductCode'];
    productName = json['ProductName'];
    barcode = json['Barcode'];
    cartonPrice = json['CartonPrice'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
  }
  int? orgId;
  String? productCode;
  String? productName;
  String? barcode;
  double? cartonPrice;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['ProductCode'] = productCode;
    map['ProductName'] = productName;
    map['Barcode'] = barcode;
    map['CartonPrice'] = cartonPrice;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    return map;
  }
}
