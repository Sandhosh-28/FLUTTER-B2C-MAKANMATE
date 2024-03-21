class CategoriesByLocation {
  CategoriesByLocation({
      this.orgId, 
      this.branchCode, 
      this.branchName, 
      this.categoryCode, 
      this.createdBy, 
      this.createdOn,});

  CategoriesByLocation.fromJson(dynamic json) {
    orgId = json['OrgId'];
    branchCode = json['BranchCode'];
    branchName = json['BranchName'];
    categoryCode = json['CategoryCode'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
  }
  int? orgId;
  String? branchCode;
  dynamic branchName;
  String? categoryCode;
  String? createdBy;
  String? createdOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['BranchCode'] = branchCode;
    map['BranchName'] = branchName;
    map['CategoryCode'] = categoryCode;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    return map;
  }

}