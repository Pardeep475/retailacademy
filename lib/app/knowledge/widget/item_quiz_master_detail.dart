import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:retail_academy/common/app_color.dart';

import '../../../common/local_storage/hive/answer_element_modal.dart';
import '../../../common/local_storage/hive/quiz_element_modal.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/multiple_checkbox_list_tile.dart';
import '../../../common/widget/radio_list_tile.dart';

class ItemQuizMasterDetail extends StatelessWidget {
  final QuizElementModal item;
  final int index;
  final Color color;
  final int listSize;
  final Function(int itemIndex, dynamic value) onItemPressed;

  const ItemQuizMasterDetail(
      {required this.item,
      required this.index,
      required this.listSize,
      this.color = AppColor.pinkKnowledge,
      required this.onItemPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r), color: color),
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: AppText(
                    text: item.question,
                    textSize: 25.sp,
                    lineHeight: 1.3,
                    fontWeight: FontWeight.w500,
                    maxLines: 5,
                    color: AppColor.white,
                    textAlign: TextAlign.start,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Align(
                  alignment: Alignment.bottomRight,
                  child: AppText(
                    text: '${index + 1}/$listSize',
                    textSize: 22.sp,
                    lineHeight: 1.3,
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                    color: AppColor.white,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Expanded(
          flex: 4,
          child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: item.answers == null ? 0 : item.answers!.length,
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                AnswerElementModal itemAnswerElement = item.answers![index];
                debugPrint('GROUP_VALUE:----    ${''}');
                if (item.questionType == 'Multiple Choice - Single Answer') {
                  return CustomRadioListTile(
                    onPressed: (value) {
                      debugPrint('CustomRadioListTile:----   $value');
                      onItemPressed(index, value);
                    },
                    title: itemAnswerElement.answer,
                    groupValue: item.groupValue,
                    value: '${itemAnswerElement.answerNo}',
                  );
                } else {
                  return MultipleCheckboxListTile(
                    onPressed: (value) {
                      debugPrint('CustomRadioListTile:----   $value');
                      onItemPressed(index, value);
                    },
                    isSelected: itemAnswerElement.isSelected,
                    title: itemAnswerElement.answer,
                  );
                }
              }),
        ),
      ],
    );
  }
}
