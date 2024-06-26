class HttpUrl {
  static const String base = 'http://154.26.130.251:302/';

  static const int org = 1;

  static String sendOtp = '${base}SendOTP/SendOTP';

  static String exitingEmailRegister = '${base}B2CCustomerRegister/GetbyEmail?';

  static String createCustomerRegister = '${base}B2CCustomerRegister/Create';

  static String verifyOtp = '${base}SendOTP/VerifyOTP';

  static String login = '${base}B2CCustomerRegister/CustomerLogin';

  static String banner = '${base}B2CBannerImage/GetAll?';

  static String getAllCategory = '${base}Category/GetAll?';

  // static String getAllCategory = '${base}Category/GetAllWithSubcategory?';

  static String getAllSubCategory = '${base}SubCategory/GetbyCategoryCode?';

  static String getAllProduct = "${base}Product/GetAllWithImageV2?";

  static String b2CCustomerDeliveryAddressGetAll =
      "${base}B2CCustomerDeliveryAddress/GetAll?";

  static String productGetByCode = '${base}Product/Getbycode?';

  static String salesOrderCreate = '${base}B2CCustomerOrder/Create';

  static String addNewAddress = '${base}B2CCustomerDeliveryAddress/Create';

  static String changePassword =
      '${base}B2CCustomerRegister/EditProfilePassword';

  static String editProfile = '${base}B2CCustomerRegister/EditProfile';

  static String customerOrderGetByCode = '${base}B2CCustomerOrder/Getbycode?';

  static String getProductByTagCode = '${base}/Product/GetByTagCode?';

  static String b2cCustomerOrderListing =
      '${base}B2CCustomerOrder/GetHeaderSearch?';
}
