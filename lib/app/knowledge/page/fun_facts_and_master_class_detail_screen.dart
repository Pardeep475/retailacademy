import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:retail_academy/app/comment/page/knowledge_content_comment_screen.dart';

import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/app_strings.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../controller/fun_facts_and_master_class_detail_controller.dart';

class FunFactsAndMasterClassDetailScreen extends StatefulWidget {
  final String fileId;

  const FunFactsAndMasterClassDetailScreen({required this.fileId, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _FunFactsAndMasterClassDetailScreenState();
}

class _FunFactsAndMasterClassDetailScreenState
    extends State<FunFactsAndMasterClassDetailScreen> {
  final FunFactsAndMasterClassDetailController _controller =
      Get.isRegistered<FunFactsAndMasterClassDetailController>()
          ? Get.find<FunFactsAndMasterClassDetailController>()
          : Get.put(FunFactsAndMasterClassDetailController());

  @override
  void initState() {
    _controller.clearAllData();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.contentDisplayApi(fileId: int.parse(widget.fileId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CustomAppBar(
                title: '',
                isBackButtonVisible: true,
                isSearchButtonVisible: false,
              ),
              Expanded(
                child: Obx(() {
                  if (_controller.showLoader.value) {
                    return const SizedBox();
                  }
                  if (_controller.filePath.isEmpty) {
                    return const SizedBox();
                  }
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
                    filePath: _controller.filePath.value,
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
                      _controller.likeOrDislikeContentKnowledgeSectionApi(
                          fileId: int.parse(widget.fileId));
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
                    onPressed: () => _commentButtonPressed(),
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
                child: Obx(() {
                  debugPrint(
                      'FileName:--- filename ${_controller.fileName.value}');
                  return AppText(
                    text: _controller.fileName.value,
                    textSize: 20.sp,
                    lineHeight: 1.1,
                    fontWeight: FontWeight.w500,
                    maxLines: 5,
                    textAlign: TextAlign.start,
                  );
                }),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 20.h),
                child: Obx(() {
                  debugPrint(
                      'FileName:--- description ${_controller.description.value}');
                  return AppText(
                    text: _controller.description.value,
                    textSize: 20.sp,
                    fontWeight: FontWeight.w500,
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

  _commentButtonPressed() {
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
                child: KnowledgeContentCommentScreen(
                  title: _controller.fileName.value,
                  hasLike: false,
                  itemMediaUrl: '',
                  fileId: int.parse(widget.fileId),
                ),
              ),
            ],
          ),
        );
      },
    );

    // Get.to(() => KnowledgeContentCommentScreen(
    //       title: item.fileName,
    //       hasLike: false,
    //       itemMediaUrl: item.thumbnailImage,
    //       fileId: item.fileId,
    //     ))?.then((value) {
    //   if (value != null && value is bool) {
    //     // _controller.updateLikeTrending(index: index, value: value);
    //   }
    // });
  }
}
