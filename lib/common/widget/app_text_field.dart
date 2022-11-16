import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_color.dart';
import '../app_strings.dart';

class AppTextField extends StatelessWidget {
  final String? placeHolder;

  final Widget? suffix;
  final bool obscureText;

  final TextEditingController? controller;

  final String? Function(String?)? validator;

  final bool isEnabled;
  final int minLines;
  final int maxLines;
  final Color fillColor;
  final bool isChangePadding;

  const AppTextField({
    Key? key,
    this.placeHolder,
    this.suffix,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.minLines = 1,
    this.maxLines = 1,
    this.isEnabled = true,
    this.isChangePadding = false,
    this.fillColor = AppColor.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLines,
      maxLines: maxLines,
      controller: controller,
      obscureText: obscureText,
      validator: (value) => validator == null ? null : validator!(value),
      decoration: InputDecoration(
          filled: true,
          hintStyle: TextStyle(
              color: AppColor.hintColor,
              fontFamily: AppStrings.robotoFont,
              fontSize: 15.sp),
          border: _border(),
          contentPadding: isChangePadding
              ? EdgeInsets.symmetric(vertical: 0, horizontal: 10.w)
              : null,
          disabledBorder: _border(),
          enabledBorder: _border(),
          focusedBorder: _border(),
          errorBorder: _border(),
          focusedErrorBorder: _border(),
          errorStyle: const TextStyle(
              color: AppColor.red, fontFamily: AppStrings.robotoFont),
          hintText: placeHolder,
          fillColor: fillColor),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0.sp)),
      borderSide: const BorderSide(
        color: AppColor.outlineBorderColor,
      ),
    );
  }
}
