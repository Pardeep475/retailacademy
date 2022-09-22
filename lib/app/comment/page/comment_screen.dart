import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../controller/comment_controller.dart';
import '../widgets/item_comment.dart';
import '../widgets/item_sent_comment.dart';

class CommentScreen extends StatefulWidget {
  final String title;
  final bool hasLike;
  final String itemMediaUrl;

  const CommentScreen(
      {required this.title,
      required this.hasLike,
      required this.itemMediaUrl,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final CommentController _controller = Get.isRegistered<CommentController>()
      ? Get.find<CommentController>()
      : Get.put(CommentController());

  final TextEditingController _textController =
  TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Column(children: [
                    SizedBox(height: 5.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Material(
                          type: MaterialType.transparency,
                          child: IconButton(
                            onPressed: () {},
                            splashColor: Colors.white54,
                            icon: SvgPicture.asset(
                              AppImages.iconHeart,
                              color: widget.hasLike ? AppColor.red : AppColor.white,
                              height: 24.r,
                            ),
                          ),
                        ),
                        Material(
                          type: MaterialType.transparency,
                          child: IconButton(
                            onPressed: () {},
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
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 10.h,bottom: 10.h),
                          itemCount: 2,
                          itemBuilder: (BuildContext context, int index) {
                            return const ItemComment();
                          }),
                    ),
                    SizedBox(height: 5.h),
                    ItemSentComment(
                      textController: _textController,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],),
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
    );
  }
}
