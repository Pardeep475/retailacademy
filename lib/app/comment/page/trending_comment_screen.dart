import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/app_strings.dart';
import '../../../common/utils.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../controller/trending_comment_controller.dart';
import '../widgets/item_comment.dart';
import '../widgets/item_sent_comment.dart';

class TrendingCommentScreen extends StatefulWidget {
  final String title;
  final bool hasLike;
  final String itemMediaUrl;
  final int activityStreamId;

  const TrendingCommentScreen(
      {required this.title,
      required this.hasLike,
      required this.itemMediaUrl,
      required this.activityStreamId,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TrendingCommentScreenState();
}

class _TrendingCommentScreenState extends State<TrendingCommentScreen> {
  final TrendingCommentController _controller =
      Get.isRegistered<TrendingCommentController>()
          ? Get.find<TrendingCommentController>()
          : Get.put(TrendingCommentController());

  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    _controller.clearValues();
    _controller.activityStreamId = widget.activityStreamId;
    _controller.hasLiked.value = widget.hasLike;
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      _controller.fetchProfileImage();
      await _controller.trendingCommentsApi();
      _scrollToBottom();
    });

  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'KeyboardVisibility update. Builder Is visible: null');
    if(MediaQuery.of(context).viewInsets.bottom != 0){
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
                CachedNetworkImage(
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
                                    _controller.trendingLikeApi();
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
                                    return ItemComment(
                                      item: _controller.dataList[index],
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
      await _controller.postCommentsApi(comment: commentText);
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
