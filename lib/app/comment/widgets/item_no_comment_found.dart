import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/app_color.dart';
import '../../../common/app_strings.dart';
import '../../../common/widget/app_text.dart';

class ItemNoCommentFound extends StatelessWidget{

  const ItemNoCommentFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: AppText(
        text: AppStrings.noCommentFound,
        textSize: 20.sp,
        maxLines: 1,
        color: AppColor.white,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w500,
      ),
    );
  }

}