import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/app_color.dart';
import '../../../common/app_strings.dart';
import '../../../common/widget/app_text.dart';

class ItemNoCommentFound extends StatelessWidget {
  final String title;

  final Color color;

  const ItemNoCommentFound(
      {Key? key,
      this.title = AppStrings.noCommentFound,
      this.color = AppColor.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: AppText(
        text: title,
        textSize: 20.sp,
        maxLines: 1,
        color: color,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
