import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/app_strings.dart';
import '../../../common/widget/app_text_field.dart';

class ItemSentComment extends StatelessWidget {
  final TextEditingController textController;

  const ItemSentComment({required this.textController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10.w,
        ),
        Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: AppColor.white),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          padding: EdgeInsets.all(12.r),
          height: 48.h,
          width: 48.w,
          child: SvgPicture.asset(
            AppImages.iconUserImagePlaceHolder,
            color: AppColor.black,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: AppTextField(
            placeHolder: AppStrings.typeHere,
            controller: textController,
            isChangePadding: true,
            fillColor: AppColor.commentTextFieldBackgroundColor,
            maxLines: 5,
            validator: (value) {
              return null;
            },
          ),
        ),
        Material(
          type: MaterialType.transparency,
          elevation: 1,
          child: IconButton(
            onPressed: () {},
            splashColor: Colors.white54,

            icon: Icon(
              Icons.send,
              size: 24.r,
              color: AppColor.white,
            ),
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
      ],
    );
  }
}
