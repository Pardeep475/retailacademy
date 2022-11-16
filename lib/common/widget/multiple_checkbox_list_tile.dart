import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_color.dart';
import 'app_text.dart';

class MultipleCheckboxListTile extends StatelessWidget {
  final String title;
  final Function(dynamic) onPressed;
  final bool isSelected;

  const MultipleCheckboxListTile(
      {required this.title,
      required this.onPressed,
      this.isSelected = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: AppText(
        text: title,
        textSize: 20.sp,
        lineHeight: 1.3,
        fontWeight: FontWeight.w400,
        maxLines: 5,
        color: AppColor.black,
        textAlign: TextAlign.start,
      ),
      leading: Checkbox(
          onChanged: (checked) {
            onPressed(checked);
          },
          value: isSelected),
    );
  }
}
