import 'dart:ui';

class AppColor {
  static final AppColor _appColor = AppColor._internal();

  factory AppColor() {
    return _appColor;
  }

  AppColor._internal();

  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const red = Color(0xFFFF0303);
  static const loaderColor = Color(0xFFFF0303);
  static const hintColor = Color(0xFF8391A1);
  static const outlineBorderColor = Color(0xFFE8ECF4);
  static const textFieldFillColor = Color(0xFFF7F8F9);
  static const buttonFillColor = Color(0xFF1E232C);
  static const grey = Color(0xFFCBCBCB);
  static const yellowKnowledge = Color(0xFFFAAF3A);
  static const redKnowledge = Color(0xFFFD4648);
  static const pinkKnowledge = Color(0xFFD479F2);
  static const greenKnowledge = Color(0xFF44CB7E);
  static const darkBlueKnowledge = Color(0xFF23608F);
  static const lightNavyBlue = Color(0xFF004566);

}
