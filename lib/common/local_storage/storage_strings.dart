class StorageStrings {
  static final StorageStrings _storageStrings = StorageStrings._internal();

  factory StorageStrings() {
    return _storageStrings;
  }

  StorageStrings._internal();

  static const isLogin = "IS_LOGIN";
  static const setUpLanguage = "SETUP_LANGUAGE";
  static const jwtToken = "JWT_TOKEN";
  static const userName = "USERNAME";
  static const userId = "USERID";
  static const userEmail = "USEREMAIL";
  static const deviceToken = "DEVICE_ID";
  static const profileImage = "PROFILE_IMAGE";
}
