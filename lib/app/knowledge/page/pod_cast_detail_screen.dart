import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/app_color.dart';
import '../../../common/app_strings.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/audio_player_widget.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../network/modal/podcast/pod_cast_response.dart';
import '../../comment/page/pod_cast_comment_screen.dart';
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
    _controller.timeSpentOnPodcast = widget.item.timeSpentOnPodcast;
    _controller.hasLiked.value = widget.item.hasLiked;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.podcastViewedByUserApi(
          podcastId: widget.item.podcastId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _controller.podcastViewedByUserApi(
            podcastId: widget.item.podcastId, isBackPressed: true);
        return Future.value(true);
      },
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                CustomAppBar(
                  title: AppStrings.podCast,
                  isBackButtonVisible: true,
                  isNotificationButtonVisible: true,
                  isIconsTitle: true,
                  onBackPressed: () {
                    _controller.podcastViewedByUserApi(
                        podcastId: widget.item.podcastId, isBackPressed: true);
                  },
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
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: CachedNetworkImage(
                    imageUrl: widget.item.thumbnailPath,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
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
                      child: Icon(
                        Icons.mic,
                        size: 90.0.r,
                      ),
                    ),
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
                        text: widget.item.podcastTitle,
                        textSize: 18.sp,
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
                        text: widget.item.podcastDescription,
                        textSize: 15.sp,
                        color: AppColor.black,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        lineHeight: 1.3,
                        fontWeight: FontWeight.w500,
                      ),
                      // SizedBox(
                      //   height: 5.w,
                      // ),
                      // AppText(
                      //   text: 'widget.item.podCastCategory',
                      //   textSize: 15.sp,
                      //   color: AppColor.black,
                      //   maxLines: 1,
                      //   textAlign: TextAlign.start,
                      //   overflow: TextOverflow.ellipsis,
                      //   lineHeight: 1.3,
                      //   fontWeight: FontWeight.w500,
                      // ),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    debugPrint(
                        'IS_LIKED:--  ${_controller.hasLiked.value}  ${widget.item.podcastFile}');
                    return AudioPlayerWidget(
                      // url: 'https://luan.xyz/files/audio/nasa_on_a_mission.mp3',
                      url: widget.item.podcastFile,
                      onLikePressed: () {
                        _controller.likeOrDislikePodcastApi(
                            podcastId: widget.item.podcastId);
                      },
                      onCommentPressed: () => _commentButtonPressed(),
                      hasLiked: _controller.hasLiked.value,
                      showLoader: (value) {
                        _controller.showLoader.value = value;
                      },
                      positionOnPressed: (value) {
                        debugPrint(
                            'POSITION_ON_PRESSED:------ -- -- -- -- -  $value');
                        _controller.timeSpentOnPodcast = value;
                      },
                      // url: widget.item.podcastFile,
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
      ),
    );
  }

  _commentButtonPressed() {
    Get.to(() => PodCastCommentScreen(
          title: widget.item.podcastTitle,
          hasLike: _controller.hasLiked.value,
          itemMediaUrl: widget.item.thumbnailPath,
          podCastId: widget.item.podcastId,
        ))?.then((value) {
      if (value != null && value is bool) {
        _controller.hasLiked.value = value;
      }
    });
  }
}
