import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:retail_academy/app/comment/page/whats_hot_blog_comment_screen.dart';
import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/app_strings.dart';
import '../../../common/utils.dart';
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
    _controller.clearAllData();
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
      body: Obx(() {
        if (_controller.showLoader.value) {
          return Container(
            color: Colors.transparent,
            width: Get.width,
            height: Get.height,
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColor.loaderColor),
              ),
            ),
          );
        }

        if (Utils.isVideo(_controller.videoUrl.value)) {
          return Stack(
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
                  child: _controller.showLoaderQuiz.value
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
          );
        } else if (Utils.isPdf(_controller.videoUrl.value)) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomAppBar(
                    title: widget.item.blogTitle.trim(),
                    isBackButtonVisible: true,
                    key: UniqueKey(),
                    isSearchButtonVisible: false,
                  ),
                  Expanded(
                    child: Obx(() {
                      if (_controller.isError.value) {
                        return Align(
                          alignment: Alignment.center,
                          child: AppText(
                            text: AppStrings.pdfError,
                            textSize: 20.sp,
                            lineHeight: 1.1,
                            fontWeight: FontWeight.w500,
                            maxLines: 5,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

                      return PDFView(
                        filePath: _controller.videoUrl.value,
                        autoSpacing: true,
                        fitPolicy: FitPolicy.BOTH,
                        onError: (e) {
                          //Show some error message or UI
                          debugPrint('PDFVIEWonError $e');
                          _controller.updateError(true);
                        },
                        onRender: (_pages) {
                          debugPrint('_totalPages $_pages');
                        },
                        onViewCreated: (PDFViewController vc) {},
                        onPageChanged: (int? page, int? total) {
                          debugPrint("_currentPage = $page");
                        },
                        onPageError: (page, e) {
                          debugPrint('PDFVIEW  onPageError $e');
                        },
                      );
                    }),
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
                            width: 28,
                            height: 28,
                          );
                        }),
                      ),
                      IconButton(
                        onPressed: () => _showCommentsBottomSheet(),
                        icon: SvgPicture.asset(
                          AppImages.iconChat,
                          color: AppColor.black,
                          width: 28,
                          height: 28,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 5.h),
                    child: AppText(
                      text: widget.item.blogTitle.trim(),
                      textSize: 20.sp,
                      lineHeight: 1.1,
                      fontWeight: FontWeight.w500,
                      maxLines: 5,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 20.h),
                    child: Obx(() {
                      debugPrint(
                          'FileName:--- description ${_controller.blogDescription.value}');
                      return AppText(
                        text: _controller.blogDescription.value,
                        textSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.start,
                      );
                    }),
                  ),
                ],
              ),
              Positioned.fill(
                child: Visibility(
                  visible: _controller.showLoaderQuiz.value,
                  child: Container(
                    color: Colors.transparent,
                    width: Get.width,
                    height: Get.height,
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColor.loaderColor),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return Stack(
          children: [
            Positioned.fill(
              child: PhotoView(
                imageProvider: NetworkImage(_controller.videoUrl.value),
                backgroundDecoration:
                    const BoxDecoration(color: AppColor.black),
                loadingBuilder: (context, event) => Container(
                  color: Colors.transparent,
                  width: Get.width,
                  height: Get.height,
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColor.loaderColor),
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
                const CustomAppBar(
                  title: '',
                  isBackButtonVisible: true,
                  isSearchButtonVisible: false,
                  isNotificationButtonVisible: true,
                  isVideoComponent: true,
                ),
                const Expanded(child: SizedBox()),
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
                              : AppColor.white,
                          width: 28,
                          height: 28,
                        );
                      }),
                    ),
                    IconButton(
                      onPressed: () => _showCommentsBottomSheet(),
                      icon: SvgPicture.asset(
                        AppImages.iconChat,
                        color: AppColor.white,
                        width: 28,
                        height: 28,
                      ),
                    )
                  ],
                ),
                CustomReadMoreText(
                  value: widget.item.blogTitle.trim(),
                ),
                CustomReadMoreText(value: _controller.blogDescription.value)
              ],
            ),
            Positioned.fill(
              child: Visibility(
                visible: _controller.showLoaderQuiz.value,
                child: Container(
                  color: Colors.transparent,
                  width: Get.width,
                  height: Get.height,
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColor.loaderColor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  _showCommentsBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.w), topRight: Radius.circular(30.w))),
      builder: (BuildContext context) {
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
                child: WhatsHotBlogCommentScreen(
                  title: widget.item.blogTitle,
                  hasLike: _controller.hasLiked.value,
                  itemMediaUrl: '',
                  blogId: widget.item.blogId,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
