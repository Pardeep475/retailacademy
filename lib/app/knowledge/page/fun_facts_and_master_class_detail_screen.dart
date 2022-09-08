import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../network/modal/knowledge/content_knowledge_response.dart';
import '../controller/fun_facts_and_master_class_detail_controller.dart';

class FunFactsAndMasterClassDetailScreen extends StatelessWidget {
  final FileElement item;

  FunFactsAndMasterClassDetailScreen({required this.item, Key? key})
      : super(key: key);

  final FunFactsAndMasterClassDetailController _controller =
      Get.isRegistered<FunFactsAndMasterClassDetailController>()
          ? Get.find<FunFactsAndMasterClassDetailController>()
          : Get.put(FunFactsAndMasterClassDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomAppBar(
            title: '',
            isBackButtonVisible: true,
            isSearchButtonVisible: true,
          ),
          const Expanded(child: SizedBox()),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  AppImages.iconHeart,
                  color: AppColor.black,
                  height: 24.r,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  AppImages.iconChat,
                  color: AppColor.black,
                  height: 24.r,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 5.h),
            child: AppText(
              text: item.fileName,
              textSize: 20.sp,
              lineHeight: 1.1,
              fontWeight: FontWeight.w500,
              maxLines: 5,
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 20.h),
            child: AppText(
              text: item.modifiedDate,
              textSize: 20.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
