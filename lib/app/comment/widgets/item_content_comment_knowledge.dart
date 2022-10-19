import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/custom_read_more_text.dart';
import '../../../network/modal/knowledge/knowledge_content_comment_response.dart';

class ItemContentCommentKnowledge extends StatelessWidget {
  final KnowledgeContentCommentElement item;
  final VoidCallback onDeleteButtonPressed;
  final int userId;
  const ItemContentCommentKnowledge(
      {required this.item, required this.onDeleteButtonPressed,required this.userId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: null,
        splashColor: Colors.white54,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 16.w,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(100.r),
                child: CachedNetworkImage(
                  imageUrl: item.profileImage,
                  height: 56.h,
                  width: 56.w,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 56.h,
                    width: 56.w,
                    decoration: BoxDecoration(
                      color: AppColor.commentBlack,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                        height: 36.r,
                        width: 36.r,
                        child: const CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColor.white),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    padding: EdgeInsets.all(12.r),
                    height: 56.h,
                    width: 56.w,
                    child: SvgPicture.asset(
                      AppImages.iconUserImagePlaceHolder,
                      color: AppColor.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      text: item.userName,
                      textSize: 16.sp,
                      maxLines: 1,
                      color: AppColor.black,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomReadMoreText(
                      value: item.comment.trim(),
                      padding: EdgeInsets.zero,
                      moreTextColor: AppColor.lightNavyBlue,
                      textColor: AppColor.black,
                    ),
                    // AppText(
                    //   text: item.comment,
                    //   textSize: 16.sp,
                    //   maxLines: 1,
                    //   color: AppColor.black,
                    //   overflow: TextOverflow.ellipsis,
                    //   fontWeight: FontWeight.w400,
                    // ),
                  ],
                ),
              ),
              item.userId == userId ?
              IconButton(
                onPressed: onDeleteButtonPressed,
                icon: const Icon(
                  Icons.delete,
                  color: AppColor.black,
                ),
              ):
              SizedBox(
                width: 16.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
