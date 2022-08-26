import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_color.dart';
import '../app_strings.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final bool? underline;
  final bool? strikeThrough;
  final double? textSize;
  final bool? capitalise;
  final int? maxLines;
  final TextAlign? textAlign;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final double? lineHeight;
  final FontStyle? fontStyle;
  final bool softWrap;
  final TextOverflow? overflow;
  final double? topPadding;

  const AppText(
      {required this.text,
      this.color,
      this.maxLines,
      this.textAlign,
      this.underline,
      this.textSize,
      this.fontFamily,
      this.fontWeight,
      this.lineHeight,
      this.fontStyle,
      this.overflow,
      this.topPadding,
      this.softWrap = false,
      this.strikeThrough,
      this.capitalise,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: topPadding ?? 0),
      child: Text(capitalise != null && capitalise! ? text.toUpperCase() : text,
          maxLines: maxLines,
          overflow:
              overflow ?? (maxLines != null ? TextOverflow.ellipsis : null),
          textAlign: textAlign,
          softWrap: softWrap,
          style: getStyle()),
    );
  }

  TextStyle getStyle() {
    return TextStyle(
        color: color,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontSize: textSize ?? 16.sp,
        fontStyle: fontStyle ?? FontStyle.normal,
        height: lineHeight ?? 1.0,
        fontFamily: fontFamily ?? AppStrings.robotoFont,
        decorationColor: color,
        decorationThickness: 1,
        decoration: strikeThrough != null && strikeThrough!
            ? TextDecoration.lineThrough
            : underline != null
                ? TextDecoration.underline
                : null);
  }
}
