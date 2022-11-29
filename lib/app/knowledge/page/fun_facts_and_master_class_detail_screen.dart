import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:retail_academy/app/comment/page/knowledge_content_comment_screen.dart';

import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/app_strings.dart';
import '../../../common/utils.dart';
import '../../../common/widget/alert_dialog_box.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../common/widget/custom_read_more_text.dart';
import '../../../common/widget/portrait_landscape_player_page.dart';
import '../../../network/modal/knowledge/quiz_category_response.dart';
import '../controller/fun_facts_and_master_class_detail_controller.dart';
import '../knowledge_navigation/knowledge_navigation.dart';
import 'quiz_master_detail_screen.dart';

class FunFactsAndMasterClassDetailScreen extends StatefulWidget {
  final String fileId;
  final int quizId;
  final String quizName;
  final bool isTrending;

  const FunFactsAndMasterClassDetailScreen(
      {required this.fileId,
      this.isTrending = false,
      required this.quizId,
      required this.quizName,
      Key? key})
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

  onBackPressed() async {
    if (widget.isTrending) {
      Get.back();
    } else {
      try {
        await Get.keys[KnowledgeNavigation.id]!.currentState!.maybePop();
      } catch (e) {
        // error
        debugPrint('ErrorWhileNavigation:----  $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
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
        if (_controller.filePath.isEmpty) {
          return const SizedBox.shrink();
        }
        if (Utils.isVideo(_controller.filePath.value)) {
          return Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: PortraitLandscapePlayerPage(
                  url: _controller.filePath.value,
                  aspectRatio: 2 / 3,
                  commentIcon: IconButton(
                    onPressed: () => _commentButtonPressed(),
                    icon: SvgPicture.asset(
                      AppImages.iconChat,
                      color: AppColor.white,
                      height: 24.r,
                    ),
                  ),
                  likeIcon: IconButton(
                    onPressed: () {
                      _controller.likeOrDislikeContentKnowledgeSectionApi(
                          fileId: int.parse(widget.fileId));
                    },
                    icon: Obx(() {
                      return SvgPicture.asset(
                        AppImages.iconHeart,
                        color: _controller.hasLiked.value
                            ? AppColor.red
                            : AppColor.white,
                        height: 24.r,
                      );
                    }),
                  ),
                  quizWidget: Visibility(
                    visible: widget.quizId > 0,
                    child: IconButton(
                      onPressed: () async {
                        QuizCategoryElement? item = await _controller
                            .getQuizMasterApi(quizId: widget.quizId);
                        if (item == null) {
                          Get.to(
                            () => QuizMasterDetailScreen(
                              quizId: widget.quizId,
                              quizName: widget.quizName,
                            ),
                          );
                        } else {
                          if (item.isAttempted) {
                            openAlreadySubmittedDialogBox(
                                title: item.categoryName);
                          } else {
                            Get.to(
                              () => QuizMasterDetailScreen(
                                quizId: widget.quizId,
                                quizName: widget.quizName,
                              ),
                            );
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.quiz_outlined,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                  descriptionWidget:
                      CustomReadMoreText(value: _controller.description.value),
                  titleWidget:
                      CustomReadMoreText(value: _controller.fileName.value),
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
        } else if (Utils.isPdf(_controller.filePath.value)) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomAppBar(
                    title: '',
                    isBackButtonVisible: true,
                    key: UniqueKey(),
                    isSearchButtonVisible: false,
                    onBackPressed: () async {
                      await onBackPressed();
                    },
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
                              fileId: int.parse(widget.fileId), isLoader: true);
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
                      ),
                      Visibility(
                        visible: widget.quizId > 0,
                        child: IconButton(
                          onPressed: () async {
                            QuizCategoryElement? item = await _controller
                                .getQuizMasterApi(quizId: widget.quizId);
                            if (item == null) {
                              Get.to(
                                () => QuizMasterDetailScreen(
                                  quizId: widget.quizId,
                                  quizName: widget.quizName,
                                ),
                              );
                            } else {
                              if (item.isAttempted) {
                                openAlreadySubmittedDialogBox(
                                    title: item.categoryName);
                              } else {
                                Get.to(
                                  () => QuizMasterDetailScreen(
                                    quizId: widget.quizId,
                                    quizName: widget.quizName,
                                  ),
                                );
                              }
                            }
                          },
                          icon: const Icon(Icons.quiz_outlined),
                        ),
                      ),
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
                imageProvider: NetworkImage(_controller.filePath.value),
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
                        _controller.likeOrDislikeContentKnowledgeSectionApi(
                            fileId: int.parse(widget.fileId));
                      },
                      icon: Obx(() {
                        return SvgPicture.asset(
                          AppImages.iconHeart,
                          color: _controller.hasLiked.value
                              ? AppColor.red
                              : AppColor.white,
                          height: 24.r,
                        );
                      }),
                    ),
                    IconButton(
                      onPressed: () => _commentButtonPressed(),
                      icon: SvgPicture.asset(
                        AppImages.iconChat,
                        color: AppColor.white,
                        height: 24.r,
                      ),
                    ),
                    Visibility(
                      visible: widget.quizId > 0,
                      child: IconButton(
                        onPressed: () async {
                          QuizCategoryElement? item = await _controller
                              .getQuizMasterApi(quizId: widget.quizId);
                          if (item == null) {
                            Get.to(
                              () => QuizMasterDetailScreen(
                                quizId: widget.quizId,
                                quizName: widget.quizName,
                              ),
                            );
                          } else {
                            if (item.isAttempted) {
                              openAlreadySubmittedDialogBox(
                                  title: item.categoryName);
                            } else {
                              Get.to(
                                () => QuizMasterDetailScreen(
                                  quizId: widget.quizId,
                                  quizName: widget.quizName,
                                ),
                              );
                            }
                          }
                        },
                        icon: const Icon(
                          Icons.quiz_outlined,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ],
                ),
                CustomReadMoreText(value: _controller.fileName.value),
                CustomReadMoreText(value: _controller.description.value)
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

  openAlreadySubmittedDialogBox({required String title}) {
    AlertDialogBox(
      showCrossIcon: true,
      context: context,
      barrierDismissible: true,
      padding: EdgeInsets.zero,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 15.h,
              ),
              AppText(
                text: AppStrings.alert,
                textSize: 22.sp,
                color: AppColor.black,
                maxLines: 2,
                lineHeight: 1.3,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 15.h,
              ),
              Divider(
                height: 1.sp,
                color: AppColor.grey,
              ),
              SizedBox(
                height: 20.h,
              ),
              AppText(
                text: '\'$title\' ${AppStrings.quizAlreadyAttempted}',
                textSize: 18.sp,
                color: AppColor.black,
                maxLines: 2,
                textAlign: TextAlign.center,
                lineHeight: 1.3,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 20.h,
              ),
              Divider(
                height: 1.sp,
                color: AppColor.grey,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                    child: AppText(
                      text: AppStrings.ok,
                      textSize: 18.sp,
                      color: Colors.lightBlue,
                      maxLines: 2,
                      lineHeight: 1.3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).show();
  }
}
