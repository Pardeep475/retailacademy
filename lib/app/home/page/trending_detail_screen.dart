import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/utils.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../common/widget/custom_read_more_text.dart';
import '../../../common/widget/portrait_landscape_player_page.dart';
import '../../../network/modal/trending/trending_response.dart';
import '../../comment/page/trending_comment_screen.dart';
import '../controller/trending_detail_controller.dart';

class TrendingDetailScreen extends StatefulWidget {
  final ActivityStream item;

  const TrendingDetailScreen({required this.item, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TrendingDetailScreenState();
}

class _TrendingDetailScreenState extends State<TrendingDetailScreen> {
  final TrendingDetailController _controller =
      Get.isRegistered<TrendingDetailController>()
          ? Get.find<TrendingDetailController>()
          : Get.put(TrendingDetailController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.clearAllData();
      _controller.fetchActivityStreamViewedApi(
          activityStreamId: widget.item.activityStreamId);
      _controller.hasLike.value = widget.item.hasLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back(result: _controller.hasLike.value);
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: AppColor.black,
        body: Utils.isVideo(widget.item.activityImage)
            ? Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: PortraitLandscapePlayerPage(
                      url: widget.item.activityImage,
                      aspectRatio: 2 / 3,
                      commentIcon: IconButton(
                        onPressed: () =>
                            _commentButtonPressed(item: widget.item),
                        icon: SvgPicture.asset(
                          AppImages.iconChat,
                          color: AppColor.white,
                          width: 28,
                          height: 28,
                        ),
                      ),
                      likeIcon: IconButton(
                        onPressed: () {
                          _controller.trendingLikeApi(
                              activityStreamId: widget.item.activityStreamId);
                        },
                        icon: Obx(() {
                          return SvgPicture.asset(
                            AppImages.iconHeart,
                            color: _controller.hasLike.value
                                ? AppColor.red
                                : AppColor.white,
                            width: 28,
                            height: 28,
                          );
                        }),
                      ),
                      descriptionWidget: CustomReadMoreText(
                          value: widget.item.activityStreamText.trim()),
                      titleWidget: CustomReadMoreText(
                          value: widget.item.userName.trim()),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAppBar(
                        title: '',
                        isVideoComponent: true,
                        onBackPressed: () {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitUp,
                          ]);
                          Get.back();
                        },
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
              )
            : Stack(
                children: [
                  Positioned.fill(
                    child: PhotoView(
                      imageProvider: NetworkImage(widget.item.activityImage),
                      backgroundDecoration:
                          const BoxDecoration(color: AppColor.black),
                      loadingBuilder: (context, event) => Container(
                        color: Colors.transparent,
                        width: Get.width,
                        height: Get.height,
                        child: const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColor.loaderColor),
                          ),
                        ),
                      ),
                      errorBuilder: (context, error, stacktrace) => Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(color: AppColor.grey),
                        child: Image.asset(
                          AppImages.imgNoImageFound,
                          height: Get.height * 0.15,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAppBar(
                        title: widget.item.userName,
                        isBackButtonVisible: true,
                        isSearchButtonVisible: false,
                        isNotificationButtonVisible: true,
                        isVideoComponent: true,
                        onBackPressed: () =>
                            Get.back(result: _controller.hasLike.value),
                      ),
                      const Expanded(child: SizedBox()),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              _controller.trendingLikeApi(
                                  activityStreamId:
                                      widget.item.activityStreamId);
                            },
                            icon: Obx(() {
                              return SvgPicture.asset(
                                AppImages.iconHeart,
                                color: _controller.hasLike.value
                                    ? AppColor.red
                                    : AppColor.white,
                                height: 24.r,
                              );
                            }),
                          ),
                          IconButton(
                            onPressed: () =>
                                _commentButtonPressed(item: widget.item),
                            icon: SvgPicture.asset(
                              AppImages.iconChat,
                              color: AppColor.white,
                              height: 24.r,
                            ),
                          )
                        ],
                      ),
                      CustomReadMoreText(
                        value: widget.item.activityStreamText.trim(),
                        padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 20.h),
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

      /*child: Scaffold(
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  title: widget.item.userName,
                  isBackButtonVisible: true,
                  isSearchButtonVisible: false,
                  isNotificationButtonVisible: true,
                  onBackPressed: () =>
                      Get.back(result: _controller.hasLike.value),
                ),
                Expanded(
                  child: Utils.isVideo(widget.item.activityImage)
                      ? const SizedBox()*/ /*VideoItems(
                          videoPlayerController: VideoPlayerController.network(
                            'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4' */ /**/ /*widget.item.activityImage*/ /**/ /*,
                          ),
                          key: UniqueKey(),
                          padding: EdgeInsets.zero,
                        )*/ /*
                      : PhotoView(
                          imageProvider:
                              NetworkImage(widget.item.activityImage),
                          backgroundDecoration:
                              const BoxDecoration(color: AppColor.white),
                          loadingBuilder: (context, event) => Container(
                            color: Colors.transparent,
                            width: Get.width,
                            height: Get.height,
                            child: const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColor.loaderColor),
                              ),
                            ),
                          ),
                          errorBuilder: (context, error, stacktrace) =>
                              Container(
                            alignment: Alignment.center,
                            decoration:
                                const BoxDecoration(color: AppColor.grey),
                            child: Image.asset(
                              AppImages.imgNoImageFound,
                              height: Get.height * 0.15,
                              color: AppColor.black,
                            ),
                          ),
                        ),
                ),
                SizedBox(height: 12.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        _controller.trendingLikeApi(
                            activityStreamId: widget.item.activityStreamId);
                      },
                      icon: Obx(() {
                        return SvgPicture.asset(
                          AppImages.iconHeart,
                          color: _controller.hasLike.value
                              ? AppColor.red
                              : AppColor.black,
                          height: 24.r,
                        );
                      }),
                    ),
                    IconButton(
                      onPressed: () => _commentButtonPressed(item: widget.item),
                      icon: SvgPicture.asset(
                        AppImages.iconChat,
                        color: AppColor.black,
                        height: 24.r,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 20.h),
                  child: ReadMoreText(
                    widget.item.activityStreamText,
                    trimLines: 2,
                    colorClickableText: AppColor.lightNavyBlue,
                    trimMode: TrimMode.line,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        height: 1.6,
                        color: AppColor.black),
                    moreStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        height: 1.6,
                        color: AppColor.lightNavyBlue),
                    lessStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        height: 1.6,
                        color: AppColor.lightNavyBlue),
                  ),
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
      ),*/
    );
  }

  _commentButtonPressed({required ActivityStream item}) {
    showModalBottomSheet<void>(
      // context and builder are
      // required properties in this widget
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.w), topRight: Radius.circular(30.w))),

      builder: (BuildContext context) {
        // we set up a container inside which
        // we create center column and display text

        // Returning SizedBox instead of a Container
        return Container(
          height: Get.height * 0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.w),
                  topRight: Radius.circular(50.w))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close)),
                ],
              ),
              Expanded(
                child: TrendingCommentScreen(
                  title: item.userName,
                  hasLike: item.hasLiked,
                  itemMediaUrl: item.activityImage,
                  activityStreamId: item.activityStreamId,
                ),
              ),
            ],
          ),
        );
      },
    );
    // Get.to(() => TrendingCommentScreen(
    //       title: item.userName,
    //       hasLike: _controller.hasLike.value,
    //       itemMediaUrl: item.activityImage,
    //       activityStreamId: item.activityStreamId,
    //     ))?.then((value) {
    //   if (value != null && value is bool) {
    //     _controller.hasLike.value = value;
    //   }
    // });
  }
}
