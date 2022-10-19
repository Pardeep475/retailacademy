import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../common/widget/custom_read_more_text.dart';
import '../../../common/widget/portrait_landscape_player_page.dart';
import '../../../network/modal/knowledge/whats_hot_blog_content_response.dart';
import '../controller/whats_hot_blog_detail_controller.dart';

class WhatsHotBogDetailScreen extends StatefulWidget {
  final BlogContentElement item;
  final int categoryId;

  const WhatsHotBogDetailScreen(
      {required this.item, required this.categoryId, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _WhatsHotBogDetailScreenState();
}

class _WhatsHotBogDetailScreenState extends State<WhatsHotBogDetailScreen> {
  final WhatsHotBlogDetailController _controller =
      Get.isRegistered<WhatsHotBlogDetailController>()
          ? Get.find<WhatsHotBlogDetailController>()
          : Get.put(WhatsHotBlogDetailController());

  // VideoPlayerController? videoPlayerController;
  // ChewieController? _chewieController;

  @override
  void initState() {
    _controller.hasLiked.value = widget.item.hasLiked;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.fetchWhatsHotContentApi(
          categoryId: widget.categoryId, blogId: widget.item.blogId);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("VideoUrl:-    ${widget.item.videoUrl}");
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: Obx(() {
              debugPrint('value:-   ${_controller.videoUrl.value} ');
              if (_controller.videoUrl.isEmpty) {
                return const SizedBox();
              }
              return PortraitLandscapePlayerPage(
                url: _controller.videoUrl.value,
                aspectRatio: 2 / 3,
                commentIcon: IconButton(
                  onPressed: () => _showCommentsBottomSheet(),
                  icon: SvgPicture.asset(
                    AppImages.iconChat,
                    color: AppColor.white,
                    width: 28,
                    height: 28,
                  ),
                ),
                likeIcon: IconButton(
                  onPressed: () {
                    _controller.likeOrDislikeBlogApi(
                        blogId: widget.item.blogId);
                  },
                  icon: Obx(() {
                    return SvgPicture.asset(
                      AppImages.iconHeart,
                      color: _controller.hasLiked.value
                          ? AppColor.red
                          : AppColor.white,
                      width: 28,
                      height: 28,
                    );
                  }),
                ),
                descriptionWidget: Obx(() {
                  return CustomReadMoreText(
                    value: _controller.blogDescription.value.trim(),
                    padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 5.h),
                  );
                }),

                titleWidget: CustomReadMoreText(
                  value: widget.item.blogTitle.trim(),
                  padding: EdgeInsets.fromLTRB(16.w, 5.h, 16.w, 0),
                ),
              );
            }),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CustomAppBar(
                title: '',
                isBackButtonVisible: true,
                isSearchButtonVisible: false,
                isNotificationButtonVisible: true,
                isVideoComponent: true,
              ),
              // Expanded(
              //   child: Obx(() {
              //     debugPrint('value:-   ${_controller.videoUrl.value}');
              //     return const SizedBox();
              //   }),
              // ),
              // SizedBox(height: 12.h),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     IconButton(
              //       onPressed: () {
              //         _controller.likeOrDislikeBlogApi(
              //             blogId: widget.item.blogId);
              //       },
              //       icon: Obx(() {
              //         return SvgPicture.asset(
              //           AppImages.iconHeart,
              //           color: _controller.hasLiked.value
              //               ? AppColor.red
              //               : AppColor.black,
              //           height: 24.r,
              //         );
              //       }),
              //     ),
              //     IconButton(
              //       onPressed: () {},
              //       icon: SvgPicture.asset(
              //         AppImages.iconChat,
              //         color: AppColor.black,
              //         height: 24.r,
              //       ),
              //     )
              //   ],
              // ),
              // Padding(
              //   padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 20.h),
              //   child: Obx(() {
              //     return AppText(
              //       text: _controller.blogDescription.value,
              //       textSize: 16.sp,
              //       fontWeight: FontWeight.w500,
              //       maxLines: 5,
              //       lineHeight: 1.2,
              //       textAlign: TextAlign.start,
              //     );
              //   }),
              // ),
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

  @override
  void dispose() {
    super.dispose();
  }

  void _showCommentsBottomSheet() {
    /*showModalBottomSheet<void>(
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
                child: RetailReelsCommentScreen(
                  title: widget.item.userName,
                  hasLike: _controller.hasLiked.value,
                  // itemMediaUrl: _controller.videoUrl.value,
                  itemMediaUrl:
                  'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
                  reelId: widget.item.reelId,
                  position: _controller.position,
                ),
              ),
            ],
          ),
        );
      },
    );*/
  }
}
