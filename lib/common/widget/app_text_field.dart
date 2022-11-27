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
  final bool isBorderRequired;
  final Function(String)? onChanged;
  final VoidCallback? onEditingComplete;

  const AppTextField({
    Key? key,
    this.placeHolder,
    this.suffix,
    this.obscureText = false,
    this.controller,
    this.isBorderRequired = true,
    this.validator,
    this.minLines = 1,
    this.maxLines = 1,
    this.isEnabled = true,
    this.isChangePadding = false,
    this.fillColor = AppColor.white,
    this.onChanged,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLines,
      maxLines: maxLines,
      controller: controller,
      obscureText: obscureText,
      validator: (value) => validator == null ? null : validator!(value),
      onChanged: (value) => onChanged == null ? null : onChanged!(value),
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: (value) {},
      onSaved: (value) {},
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
    return isBorderRequired
        ? OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0.sp)),
            borderSide: const BorderSide(
              color: AppColor.outlineBorderColor,
            ),
          )
        : OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0.sp)),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          );
  }
}
