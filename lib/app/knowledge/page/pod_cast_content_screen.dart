import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/app/knowledge/controller/pod_cast_content_controller.dart';
import 'package:retail_academy/app/knowledge/widget/item_pod_cast.dart';

import '../../../common/app_color.dart';
import '../../../common/app_strings.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../common/widget/no_data_available.dart';
import '../../../network/modal/podcast/pod_cast_category_response.dart';
import '../../../network/modal/podcast/pod_cast_response.dart';

class PodCastContentScreen extends StatefulWidget {
  final PodCastCategoryElement item;

  const PodCastContentScreen({required this.item, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PodCastContentScreenState();
}

class _PodCastContentScreenState extends State<PodCastContentScreen> {
  final PodCastContentController _controller =
      Get.isRegistered<PodCastContentController>()
          ? Get.find<PodCastContentController>()
          : Get.put(PodCastContentController());

  @override
  void initState() {
    _controller.item = widget.item;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getPodCastApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const CustomAppBar(
                title: AppStrings.podCast,
                isBackButtonVisible: true,
                isNotificationButtonVisible: true,
                isIconsTitle: true,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 16.w,),
                  Container(
                    height: 130.h,
                    width: 130.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColor.grey,
                        borderRadius: BorderRadius.circular(5.r)),
                    child: Icon(
                      Icons.mic,
                      size: 36.0.r,
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppText(
                          text: widget.item.podCastCategory,
                          textSize: 15.sp,
                          color: AppColor.black,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          lineHeight: 1.3,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 5.w,
                        ),
                        AppText(
                          text: widget.item.podCastCategory,
                          textSize: 15.sp,
                          color: AppColor.black,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          lineHeight: 1.3,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w,),
                ],
              ),
              Expanded(
                child: Obx(() {
                  if (!_controller.showLoader.value &&
                      _controller.dataList.isEmpty) {
                    return NoDataAvailable(
                      onPressed: () => _controller.getPodCastApi(),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => _controller.getPodCastApi(isLoader: false),
                    child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: ClampingScrollPhysics()),
                        shrinkWrap: true,
                        itemCount: _controller.dataList.length,
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        itemBuilder: (BuildContext context, int index) {
                          PodcastElement item = _controller.dataList[index];
                          return ItemPodCast(
                            item: item,
                            onItemPressed: () {},
                          );
                        }),
                  );
                }),
              ),
            ],
          ),
          Obx(
            () => Positioned.fill(
              child: _controller.showLoader.value
                  ? Container(
                      color: Colors.transparent,
                      width: Get.width,
                      height: Get.height,
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColor.loaderColor),
                        ),
                      ),
                    )
                  : Container(
                      width: 0,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
