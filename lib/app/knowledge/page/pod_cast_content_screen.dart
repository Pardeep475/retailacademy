import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/app/comment/page/pod_cast_comment_screen.dart';
import 'package:retail_academy/app/knowledge/controller/pod_cast_content_controller.dart';
import 'package:retail_academy/app/knowledge/page/pod_cast_detail_screen.dart';
import 'package:retail_academy/app/knowledge/widget/item_pod_cast.dart';

import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/app_strings.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../common/widget/custom_read_more_text.dart';
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 16.w,
                  ),
                  Container(
                    height: 130.h,
                    width: 130.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: widget.item.color,
                        borderRadius: BorderRadius.circular(5.r)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    // child: Icon(
                    //   Icons.mic,
                    //   size: 36.0.r,
                    // ),
                    child: CachedNetworkImage(
                      imageUrl: widget.item.categoryThumbnailImage,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
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
                        child: Image.asset(
                          AppImages.imgNoImageFound,
                          color: AppColor.black,
                          height: 50.h,
                          width: 50.h,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppText(
                          text: widget.item.podCastCategoryTitle,
                          textSize: 15.sp,
                          color: AppColor.black,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          lineHeight: 1.3,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: widget.item.podCastCategoryDescription.isEmpty
                              ? 0
                              : 5.w,
                        ),
                        widget.item.podCastCategoryDescription.isEmpty
                            ? const SizedBox()
                            : CustomReadMoreText(
                                value: widget.item.podCastCategoryDescription
                                    .trim(),
                                padding: EdgeInsets.zero,
                                moreTextColor: AppColor.lightNavyBlue,
                                textColor: AppColor.black,
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
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
                            onItemPressed: () {
                              Get.to(PodCastDetailScreen(
                                item: item,
                              ))?.then((value) {
                                if (value != null && value is bool) {
                                  _controller.updateLikePodCast(
                                      index: index, value: value);
                                }
                              });
                            },
                            onCommentPressed: () =>
                                _commentButtonPressed(index: index),
                            onLikePressed: () {
                              _controller.likeOrDislikePodcastApi(
                                  index: index, podcastId: item.podcastId);
                            },
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

  _commentButtonPressed({required int index}) {
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
                child: PodCastCommentScreen(
                  title: _controller.dataList[index].podcastTitle,
                  hasLike: _controller.dataList[index].hasLiked,
                  itemMediaUrl: _controller.dataList[index].thumbnailPath,
                  podCastId: _controller.dataList[index].podcastId,
                ),
              ),
            ],
          ),
        );
      },
    );
    // Get.to(() => PodCastCommentScreen(
    //       title: _controller.dataList[index].podcastTitle,
    //       hasLike: _controller.dataList[index].hasLiked,
    //       itemMediaUrl: _controller.dataList[index].thumbnailPath,
    //       podCastId: _controller.dataList[index].podcastId,
    //     ))?.then((value) {
    //   if (value != null && value is bool) {
    //     _controller.updateLikePodCast(index: index, value: value);
    //   }
    // });
  }
}
