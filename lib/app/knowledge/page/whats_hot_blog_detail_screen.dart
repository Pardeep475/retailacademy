import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../network/modal/knowledge/whats_hot_blog_content_response.dart';
import '../controller/whats_hot_blog_detail_controller.dart';
import '../widget/video_items.dart';

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


  @override
  void initState() {
    _controller.hasLiked.value = widget.item.hasLiked;
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: widget.item.blogTitle,
                isBackButtonVisible: true,
                isSearchButtonVisible: false,
                isNotificationButtonVisible: true,
              ),
              Expanded(
                child: VideoItems(
                  videoPlayerController: VideoPlayerController.network(
                    // widget.item.videoUrl,
                    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
                  ),
                  key: UniqueKey(),
                  padding: EdgeInsets.zero,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      _controller.likeOrDislikeBlogApi(
                          blogId: widget.item.blogId);
                    },
                    icon: Obx(() {
                      return SvgPicture.asset(
                        AppImages.iconHeart,
                        color: _controller.hasLiked.value
                            ? AppColor.red
                            : AppColor.black,
                        height: 24.r,
                      );
                    }),
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
                padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 20.h),
                child: Obx(() {
                  return AppText(
                    text: _controller.blogDescription.value,
                    textSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    maxLines: 5,
                    lineHeight: 1.2,
                    textAlign: TextAlign.start,
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
