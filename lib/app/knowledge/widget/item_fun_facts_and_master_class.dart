import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:retail_academy/common/app_images.dart';

import '../../../common/app_color.dart';
import '../../../common/widget/app_text.dart';

class ItemFunFactsAndMasterClass extends StatelessWidget {
  final Color color;

  const ItemFunFactsAndMasterClass({required this.color, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImages.iconHeart,
            height: 80.h,
            width: 80.w,
          ),
          SizedBox(
            height: 20.h,
          ),
          AppText(
            text: 'Title',
            textSize: 20.sp,
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            color: AppColor.white,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
