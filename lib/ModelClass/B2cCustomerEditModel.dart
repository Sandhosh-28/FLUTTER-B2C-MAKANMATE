class B2cCustomerEditModel {
  B2cCustomerEditModel({
    this.orgId,
    this.b2CCustomerId,
    this.b2CCustomerName,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.countryId,
    this.postalCode,
    this.mobileNo,
    this.changedBy,
    this.changedOn,
  });

  B2cCustomerEditModel.fromJson(dynamic json) {
    orgId = json['OrgId'];
    b2CCustomerId = json['B2CCustomerId'];
    b2CCustomerName = json['B2CCustomerName'];
    addressLine1 = json['AddressLine1'];
    addressLine2 = json['AddressLine2'];
    addressLine3 = json['AddressLine3'];
    countryId = json['CountryId'];
    postalCode = json['PostalCode'];
    mobileNo = json['MobileNo'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
  }
  int? orgId;
  String? b2CCustomerId;
  String? b2CCustomerName;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? countryId;
  String? postalCode;
  String? mobileNo;
  String? changedBy;
  String? changedOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['B2CCustomerId'] = b2CCustomerId;
    map['B2CCustomerName'] = b2CCustomerName;
    map['AddressLine1'] = addressLine1;
    map['AddressLine2'] = addressLine2;
    map['AddressLine3'] = addressLine3;
    map['CountryId'] = countryId;
    map['PostalCode'] = postalCode;
    map['MobileNo'] = mobileNo;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    return map;
  }
}
