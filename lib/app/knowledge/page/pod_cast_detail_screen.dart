import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/app_strings.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/audio_player_widget.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../network/modal/podcast/pod_cast_response.dart';
import '../controller/pod_cast_detail_controller.dart';

class PodCastDetailScreen extends StatefulWidget {
  final PodcastElement item;

  const PodCastDetailScreen({required this.item, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PodCastDetailScreenState();
}

class _PodCastDetailScreenState extends State<PodCastDetailScreen> {
  final PodCastDetailController _controller =
      Get.isRegistered<PodCastDetailController>()
          ? Get.find<PodCastDetailController>()
          : Get.put(PodCastDetailController());

  @override
  void initState() {
    _controller.item = widget.item;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _controller.getPodCastApi();
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
              Container(
                height: Get.height * 0.4,
                width: Get.width,
                margin: EdgeInsets.only(
                    top: 16.h, left: 30.w, right: 30.w, bottom: 16.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppColor.grey,
                    borderRadius: BorderRadius.circular(5.r)),
                child: Icon(
                  Icons.mic,
                  size: 36.0.r,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  left: 30.w,
                  right: 30.w,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: 'widget.item.podCastCategory',
                      textSize: 15.sp,
                      color: AppColor.black,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      lineHeight: 1.3,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 5.w,
                    ),
                    AppText(
                      text: 'widget.item.podCastCategory',
                      textSize: 15.sp,
                      color: AppColor.black,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      lineHeight: 1.3,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 5.w,
                    ),
                    AppText(
                      text: 'widget.item.podCastCategory',
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
              const Expanded(
                child: AudioPlayerWidget(
                  url: 'https://luan.xyz/files/audio/nasa_on_a_mission.mp3',
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 16.w,
                  ),
                  IconButton(
                    onPressed: () {
                      // _controller.likeOrDislikeBlogApi(
                      //     blogId: widget.item.blogId);
                    },
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
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.volume_up,
                      size: 28.r,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.settings,
                      size: 28.r,
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                ],
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
