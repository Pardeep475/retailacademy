import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/common/app_images.dart';
import 'package:retail_academy/network/modal/knowledge/content_knowledge_response.dart';

import '../../../common/app_color.dart';
import '../../../common/routes/route_strings.dart';
import '../../../common/widget/app_text.dart';

class ItemFolderKnowledge extends StatelessWidget {
  final Color color;
  final FileElement item;

  const ItemFolderKnowledge({Key? key, required this.color, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('${item.thumbnailImage}\n');
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8.r)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            debugPrint("asdfghjkl");
            var arguments = <String, dynamic>{
              "title": item.fileName,
              "fileId": item.fileId,
            };
            Get.toNamed(RouteString.funFactsAndMasterClassContentScreen,
                arguments: arguments);
          },
          splashColor: Colors.white54,
          borderRadius: BorderRadius.circular(8.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(15.r),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ]),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: CachedNetworkImage(
                  imageUrl: item.thumbnailImage,
                  height: 48.h,
                  width: 48.w,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 48.h,
                    width: 48.w,
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
                    child: Image.asset(
                      AppImages.imgNoImageFound,
                      height: 36.h,
                      width: 36.w,
                      color: AppColor.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              AppText(
                text: item.fileName,
                textSize: 20.sp,
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                color: AppColor.white,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemContentKnowledge extends StatelessWidget {
  final FileElement item;
  final VoidCallback onPressed;

  const ItemContentKnowledge({Key? key,required this.onPressed, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          splashColor: Colors.white54,
          borderRadius: BorderRadius.circular(8.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CachedNetworkImage(
                    imageUrl: item.thumbnailImage,
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
                      decoration: const BoxDecoration(color: AppColor.grey),
                      child: Image.asset(
                        AppImages.imgNoImageFound,
                        height: Get.height * 0.15,
                        color: AppColor.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  const Icon(Icons.file_copy),
                  SizedBox(
                    width: 5.h,
                  ),
                  Expanded(
                    child: AppText(
                      text: item.fileName,
                      textSize: 16.sp,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      color: AppColor.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 5.h,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
