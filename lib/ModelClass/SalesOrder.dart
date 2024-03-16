class SalesOrder {
  SalesOrder({
    this.orgId,
    this.brachCode,
    this.orderNo,
    this.mobileNo,
    this.emailId,
    this.orderDate,
    this.customerId,
    this.customerName,
    this.customerAddress,
    this.postalCode,
    this.taxCode,
    this.taxType,
    this.taxPerc,
    this.currencyCode,
    this.currencyRate,
    this.total,
    this.billDiscount,
    this.billDiscountPerc,
    this.subTotal,
    this.tax,
    this.netTotal,
    this.paymentType,
    this.paidAmount,
    this.remarks,
    this.isActive,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.status,
    this.customerShipToId,
    this.customerShipToAddress,
    this.latitude,
    this.longitude,
    this.signatureimage,
    this.cameraimage,
    this.orderDateString,
    this.createdFrom,
    this.customerEmail,
    this.orderDetail,
    this.deliveryAmount,
  });

  SalesOrder.fromJson(dynamic json) {
    orgId = json['OrgId'];
    brachCode = json['BrachCode'];
    orderNo = json['OrderNo'];
    mobileNo = json['MobileNo'];
    emailId = json['EmailId'];
    orderDate = json['OrderDate'];
    customerId = json['CustomerId'];
    customerName = json['CustomerName'];
    customerAddress = json['CustomerAddress'];
    postalCode = json['PostalCode'];
    taxCode = json['TaxCode'];
    taxType = json['TaxType'];
    taxPerc = json['TaxPerc'];
    currencyCode = json['CurrencyCode'];
    currencyRate = json['CurrencyRate'];
    total = json['Total'];
    billDiscount = json['BillDiscount'];
    billDiscountPerc = json['BillDiscountPerc'];
    subTotal = json['SubTotal'];
    tax = json['Tax'];
    netTotal = json['NetTotal'];
    paymentType = json['PaymentType'];
    paidAmount = json['PaidAmount'];
    remarks = json['Remarks'];
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    status = json['Status'];
    customerShipToId = json['CustomerShipToId'];
    customerShipToAddress = json['CustomerShipToAddress'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    signatureimage = json['Signatureimage'];
    cameraimage = json['Cameraimage'];
    orderDateString = json['OrderDateString'];
    createdFrom = json['CreatedFrom'];
    customerEmail = json['CustomerEmail'];
    if (json['OrderDetail'] != null) {
      orderDetail = [];
      json['OrderDetail'].forEach((v) {
        orderDetail?.add(OrderDetail.fromJson(v));
      });
    }
    deliveryAmount = json['DeliveryAmount'];
  }
  int? orgId;
  String? brachCode;
  String? orderNo;
  String? mobileNo;
  String? emailId;
  String? orderDate;
  String? customerId;
  String? customerName;
  String? customerAddress;
  String? postalCode;
  double? taxCode;
  String? taxType;
  double? taxPerc;
  String? currencyCode;
  int? currencyRate;
  double? total;
  double? billDiscount;
  double? billDiscountPerc;
  double? subTotal;
  double? tax;
  double? netTotal;
  String? paymentType;
  double? paidAmount;
  String? remarks;
  bool? isActive;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  int? status;
  int? customerShipToId;
  String? customerShipToAddress;
  double? latitude;
  double? longitude;
  String? signatureimage;
  String? cameraimage;
  String? orderDateString;
  String? createdFrom;
  String? customerEmail;
  List<OrderDetail>? orderDetail;
  double? deliveryAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['BrachCode'] = brachCode;
    map['OrderNo'] = orderNo;
    map['MobileNo'] = mobileNo;
    map['EmailId'] = emailId;
    map['OrderDate'] = orderDate;
    map['CustomerId'] = customerId;
    map['CustomerName'] = customerName;
    map['CustomerAddress'] = customerAddress;
    map['PostalCode'] = postalCode;
    map['TaxCode'] = taxCode;
    map['TaxType'] = taxType;
    map['TaxPerc'] = taxPerc;
    map['CurrencyCode'] = currencyCode;
    map['CurrencyRate'] = currencyRate;
    map['Total'] = total;
    map['BillDiscount'] = billDiscount;
    map['BillDiscountPerc'] = billDiscountPerc;
    map['SubTotal'] = subTotal;
    map['Tax'] = tax;
    map['NetTotal'] = netTotal;
    map['PaymentType'] = paymentType;
    map['PaidAmount'] = paidAmount;
    map['Remarks'] = remarks;
    map['IsActive'] = isActive;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['Status'] = status;
    map['CustomerShipToId'] = customerShipToId;
    map['CustomerShipToAddress'] = customerShipToAddress;
    map['Latitude'] = latitude;
    map['Longitude'] = longitude;
    map['Signatureimage'] = signatureimage;
    map['Cameraimage'] = cameraimage;
    map['OrderDateString'] = orderDateString;
    map['CreatedFrom'] = createdFrom;
    map['CustomerEmail'] = customerEmail;
    if (orderDetail != null) {
      map['OrderDetail'] = orderDetail?.map((v) => v.toJson()).toList();
    }
    map['DeliveryAmount'] = deliveryAmount;
    return map;
  }
}

class OrderDetail {
  OrderDetail({
    this.orgId,
    this.orderNo,
    this.slNo,
    this.productCode,
    this.productName,
    this.qty,
    this.price,
    this.foc,
    this.total,
    this.itemDiscount,
    this.itemDiscountPerc,
    this.subTotal,
    this.tax,
    this.netTotal,
    this.taxCode,
    this.taxType,
    this.taxPerc,
    this.remarks,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.weight,
  });

  OrderDetail.fromJson(dynamic json) {
    orgId = json['OrgId'];
    orderNo = json['OrderNo'];
    slNo = json['SlNo'];
    productCode = json['ProductCode'];
    productName = json['ProductName'];
    qty = json['Qty'];
    price = json['Price'];
    foc = json['Foc'];
    total = json['Total'];
    itemDiscount = json['ItemDiscount'];
    itemDiscountPerc = json['ItemDiscountPerc'];
    subTotal = json['SubTotal'];
    tax = json['Tax'];
    netTotal = json['NetTotal'];
    taxCode = json['TaxCode'];
    taxType = json['TaxType'];
    taxPerc = json['TaxPerc'];
    remarks = json['Remarks'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    weight = json['Weight'];
  }
  int? orgId;
  String? orderNo;
  int? slNo;
  String? productCode;
  String? productName;
  int? qty;
  double? price;
  int? foc;
  double? total;
  int? itemDiscount;
  int? itemDiscountPerc;
  double? subTotal;
  double? tax;
  double? netTotal;
  int? taxCode;
  String? taxType;
  double? taxPerc;
  String? remarks;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  int? weight;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['OrderNo'] = orderNo;
    map['SlNo'] = slNo;
    map['ProductCode'] = productCode;
    map['ProductName'] = productName;
    map['Qty'] = qty;
    map['Price'] = price;
    map['Foc'] = foc;
    map['Total'] = total;
    map['ItemDiscount'] = itemDiscount;
    map['ItemDiscountPerc'] = itemDiscountPerc;
    map['SubTotal'] = subTotal;
    map['Tax'] = tax;
    map['NetTotal'] = netTotal;
    map['TaxCode'] = taxCode;
    map['TaxType'] = taxType;
    map['TaxPerc'] = taxPerc;
    map['Remarks'] = remarks;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['Weight'] = weight;
    return map;
  }
}
