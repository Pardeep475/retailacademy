import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:retail_academy/common/app_color.dart';

import '../../../common/widget/custom_app_bar.dart';
import '../widget/item_fun_facts_and_master_class.dart';

class FunFactsAndMasterClassScreen extends StatefulWidget {
  const FunFactsAndMasterClassScreen(
      { Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FunFactsAndMasterClassScreenState();
}

class _FunFactsAndMasterClassScreenState
    extends State<FunFactsAndMasterClassScreen> {
  String? title;
  Color? color;

  @override
  void initState() {
    Map<String,dynamic> value = Get.arguments;
    title = value['title'];
    color = value['color'];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: title ?? '',
            isBackButtonVisible: true,
            isSearchButtonVisible: true,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 10,
              padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 20.h),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 1.3,
                  mainAxisSpacing: 8.0),
              itemBuilder: (BuildContext context, int index) {
                return ItemFunFactsAndMasterClass(
                  color: color ?? AppColor.yellowKnowledge,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
