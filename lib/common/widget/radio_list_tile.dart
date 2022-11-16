import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_color.dart';
import 'app_text.dart';

class CustomRadioListTile extends StatelessWidget {
  final String title;
  final String value;
  final String groupValue;
  final Function(dynamic) onPressed;

  const CustomRadioListTile(
      {required this.title,
      required this.value,
      required this.groupValue,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: AppText(
        text: title,
        textSize: 20.sp,
        lineHeight: 1.3,
        fontWeight: FontWeight.w400,
        maxLines: 5,
        color: AppColor.black,
        textAlign: TextAlign.start,
      ),
      value: value,
      groupValue: groupValue,
      onChanged: (value) {
        onPressed(value);
      },
    );
  }
}
