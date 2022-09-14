import 'dart:math';

import 'package:flutter/material.dart';

class WhatsHotBlogResponse {
  WhatsHotBlogResponse({
    this.blogCategoryList,
    this.status = false,
    this.message = '',
  });

  List<BlogCategoryElement>? blogCategoryList;
  bool status;
  String message;

  factory WhatsHotBlogResponse.fromJson(Map<String, dynamic> json) =>
      WhatsHotBlogResponse(
        blogCategoryList: json["blogcategorylist"] == null
            ? null
            : List<BlogCategoryElement>.from(json["blogcategorylist"]
                .map((x) => BlogCategoryElement.fromJson(x))),
        status: json["status"] ?? false,
        message: json["message"] ?? '',
      );
}

class BlogCategoryElement {
  BlogCategoryElement({
    this.categoryId = -1,
    this.blogCategory = '',
    this.hasViewed = false,
    this.color = const Color(0xffFCED22),
  });

  int categoryId;
  String blogCategory;
  bool hasViewed;
  Color color;

  factory BlogCategoryElement.fromJson(Map<String, dynamic> json) =>
      BlogCategoryElement(
        categoryId: json["categoryid"],
        blogCategory: json["blogcategory"],
        hasViewed: json["hasviewed"],
        color: colorList[Random().nextInt(6)]
      );
}

const colorList =  [
   Color(0xffFCED22),
   Color(0xff83E7F7),
   Color(0xffF76D6D),
   Color(0xffF8A5AD),
   Color(0xffE3A541),
   Color(0xffC1FF5C),
];