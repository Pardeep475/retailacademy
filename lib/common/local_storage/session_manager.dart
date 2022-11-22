import 'package:shared_preferences/shared_preferences.dart';
import 'storage_strings.dart';

class SessionManager {
  static final SessionManager _sessionManager = SessionManager._internal();

  factory SessionManager() {
    return _sessionManager;
  }

  SessionManager._internal();

  static final Future<SharedPreferences> _pref =
      SharedPreferences.getInstance();

  static void setLogin(bool isLogin) {
    _pref.then((value) => value.setBool(StorageStrings.isLogin, isLogin));
  }

  static Future<bool> isLogin() {
    return _pref
        .then((value) => value.getBool(StorageStrings.isLogin) ?? false);
  }

  static void setToken(String jwtToken) {
    _pref.then((value) => value.setString(StorageStrings.jwtToken, jwtToken));
  }

  static Future<String?> getToken() {
    return _pref
        .then((value) => value.getString(StorageStrings.jwtToken) ?? '');
  }

  static void setUserName(String userName) {
    _pref.then((value) => value.setString(StorageStrings.userName, userName));
  }

  static Future<String> getUserName() {
    return _pref
        .then((value) => value.getString(StorageStrings.userName) ?? '');
  }

  static void setUserId(String userId) {
    _pref.then((value) => value.setString(StorageStrings.userId, userId));
  }

  static void setUserEmail(String userEmail) {
    _pref.then((value) => value.setString(StorageStrings.userEmail, userEmail));
  }

  static Future<String> getUserEmail() {
    return _pref
        .then((value) => value.getString(StorageStrings.userEmail) ?? '');
  }

  static Future<String> getUserId() {
    return _pref.then((value) => value.getString(StorageStrings.userId) ?? '');
  }

  static void setDeviceToken(String deviceToken) {
    _pref.then(
        (value) => value.setString(StorageStrings.deviceToken, deviceToken));
  }

  static Future<String> getDeviceToken() {
    return _pref
        .then((value) => value.getString(StorageStrings.deviceToken) ?? '');
  }

  static void setProfileImage(String profileImage) {
    _pref.then(
        (value) => value.setString(StorageStrings.profileImage, profileImage));
  }

  static Future<String> getProfileImage() {
    return _pref
        .then((value) => value.getString(StorageStrings.profileImage) ?? '');
  }

  static clearAllData() async {
    _pref.then((value) => value.clear());
  }
}
