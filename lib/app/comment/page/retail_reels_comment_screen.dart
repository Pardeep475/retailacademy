import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:retail_academy/app/comment/widgets/item_retail_reels_comment.dart';
import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/app_strings.dart';
import '../../../common/utils.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../network/modal/retails_reels/retail_reels_comment_response.dart';
import '../controller/retail_reels_comment_controller.dart';
import '../widgets/item_no_comment_found.dart';
import '../widgets/item_sent_comment.dart';
import 'full_screen_image_and_video_screen.dart';

class RetailReelsCommentScreen extends StatefulWidget {
  final String title;
  final bool hasLike;
  final String itemMediaUrl;
  final int reelId;

  const RetailReelsCommentScreen(
      {required this.title,
      required this.hasLike,
      required this.itemMediaUrl,
      required this.reelId,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _RetailReelsCommentScreenState();
}

class _RetailReelsCommentScreenState extends State<RetailReelsCommentScreen> {
  final RetailReelsCommentController _controller =
      Get.isRegistered<RetailReelsCommentController>()
          ? Get.find<RetailReelsCommentController>()
          : Get.put(RetailReelsCommentController());

  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _controller.clearValues();
    _controller.reelId = widget.reelId;
    _controller.hasLiked.value = widget.hasLike;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _controller.fetchProfileImage();
      await _controller.retailReelsCommentsApi();
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('KeyboardVisibility update. Builder Is visible: null');
    if (MediaQuery.of(context).viewInsets.bottom != 0) {
      _scrollToBottom();
    }
    return WillPopScope(
      onWillPop: () {
        Get.back(result: _controller.hasLiked.value);
        return Future.value(true);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  title: widget.title,
                  isBackButtonVisible: true,
                  isSearchButtonVisible: false,
                  isNotificationButtonVisible: true,
                  onBackPressed: () {
                    Get.back(result: _controller.hasLiked.value);
                  },
                ),
                GestureDetector(
                  onTap: () {
                    if (widget.itemMediaUrl.isNotEmpty) {
                      Get.to(() => FullScreenImageAndVideoScreen(
                            url: widget.itemMediaUrl,
                        title: widget.title,
                          ));
                    }
                  },
                  child: CachedNetworkImage(
                    imageUrl: widget.itemMediaUrl,
                    height: Get.height * 0.25,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        color: AppColor.black,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.contain),
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
                      decoration: const BoxDecoration(color: AppColor.grey),
                      child: Image.asset(
                        AppImages.imgNoImageFound,
                        height: Get.height * 0.15,
                        color: AppColor.black,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: AppColor.commentBlack,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Material(
                              type: MaterialType.transparency,
                              child: Obx(() {
                                debugPrint(
                                    'HasLiked:---   ${_controller.hasLiked.value}');
                                return IconButton(
                                  onPressed: () {
                                    _controller.retailReelsLikeApi();
                                  },
                                  splashColor: Colors.white54,
                                  icon: SvgPicture.asset(
                                    AppImages.iconHeart,
                                    color: _controller.hasLiked.value
                                        ? AppColor.red
                                        : AppColor.white,
                                    height: 24.r,
                                  ),
                                );
                              }),
                            ),
                            Material(
                              type: MaterialType.transparency,
                              child: IconButton(
                                onPressed: () {
                                  _controller.updateCommentShown();
                                },
                                splashColor: Colors.white54,
                                icon: SvgPicture.asset(
                                  AppImages.iconChat,
                                  color: AppColor.white,
                                  height: 24.r,
                                ),
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: Obx(() {
                            debugPrint(
                                'length:----   ${_controller.dataList.length}  ${_controller.isCommentShown.value}');
                            if (!_controller.showLoader.value &&
                                _controller.dataList.isEmpty) {
                              return const ItemNoCommentFound();
                            }

                            return Visibility(
                              visible: _controller.isCommentShown.value,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(
                                    top: 10.h,
                                  ),
                                  controller: _scrollController,
                                  itemCount: _controller.dataList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final ReelCommentElement item =
                                        _controller.dataList[index];
                                    return ItemRetailReelsComment(
                                      item: item,
                                      userId: int.parse(_controller.userId),
                                      onDeleteButtonPressed: () {
                                        _controller.deleteRetailReelsApi(
                                            index: index,
                                            commentId: item.commentId);
                                      },
                                    );
                                  }),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(() {
                  debugPrint(
                      'UserProfileImage:---   ${_controller.userProfileImage.value}');
                  return ItemSentComment(
                    userProfileImage: _controller.userProfileImage.value,
                    textController: _textController,
                    onPressed: () => _sendCommentOnPressed(),
                  );
                }),
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

  _sendCommentOnPressed() async {
    if (_textController.text.isEmpty) {
      Utils.errorSnackBar(AppStrings.error, AppStrings.commentMustNotBeEmpty);
    } else {
      FocusScope.of(context).unfocus();
      var commentText = _textController.text;
      _textController.text = '';
      await _controller.retailReelsPostCommentsApi(comment: commentText);
      _scrollToBottom();
    }
  }

  _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
    });
  }
}
