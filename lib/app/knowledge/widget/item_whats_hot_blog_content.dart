import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common/app_color.dart';
import '../../../network/modal/knowledge/whats_hot_blog_content_response.dart';

class ItemWhatsHotBlogContent extends StatelessWidget {
  final BlogContentElement item;
  final VoidCallback onPressed;

  const ItemWhatsHotBlogContent(
      {Key? key, required this.item, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: item.thumbnailImage,
            height: Get.height * 0.4,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
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
              decoration: const BoxDecoration(color: Colors.black12),
              // child: Image.asset(
              //   AppImages.imgNoImageFound,
              //   height: 60.r,
              //   color: AppColor.black,
              // ),
            ),
          ),
          // IconButton(
          //   onPressed: onPressed,
          //   icon: Icon(
          //     Icons.play_arrow_rounded,
          //     size: 64.r,
          //     color: Colors.grey,
          //   ),
          // ),
          Icon(
            Icons.play_arrow_rounded,
            size: 64.r,
            color: AppColor.grey,
          )
        ],
      ),
    );
  }
}
