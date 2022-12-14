import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:retail_academy/app/knowledge/page/fun_facts_and_master_class_detail_screen.dart';
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
              SvgPicture.asset(
                AppImages.iconHeart,
                height: 80.h,
                width: 80.w,
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

  const ItemContentKnowledge({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.to(
              FunFactsAndMasterClassDetailScreen(
                item: item,
              ),
            );
          },
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
                    imageUrl: '',
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
