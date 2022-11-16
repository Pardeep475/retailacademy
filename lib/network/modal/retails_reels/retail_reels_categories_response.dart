import 'package:flutter/material.dart';

class RetailReelsCategoriesResponse {
  RetailReelsCategoriesResponse({
    this.retailReelsCategoryList,
    this.status = false,
    this.message = '',
  });

  List<RetailReelsCategoryElement>? retailReelsCategoryList;
  bool status;
  String message;

  factory RetailReelsCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      RetailReelsCategoriesResponse(
        retailReelsCategoryList: json["reelcategorylist"] == null
            ? null
            : List<RetailReelsCategoryElement>.from(json["reelcategorylist"]
                .map((x) => RetailReelsCategoryElement.fromJson(x))),
        status: json["status"] ?? false,
        message: json["message"] ?? '',
      );
}

class RetailReelsCategoryElement {
  RetailReelsCategoryElement({
    this.categoryId = -1,
    this.reelCategory = '',
    this.thumbnailImage = '',
    this.hasViewed = false,
    this.color = const Color(0xffFCED22),
  });

  int categoryId;
  String reelCategory;
  String thumbnailImage;
  bool hasViewed;
  Color color;

  int value = 0;

  factory RetailReelsCategoryElement.fromJson(Map<String, dynamic> json) =>
      RetailReelsCategoryElement(
        categoryId: json["categoryid"] ?? -1,
        reelCategory: json["reelcategory"] ?? '',
        thumbnailImage: json["thumbnailImage"] ?? '',
        hasViewed: json["hasviewed"] ?? false,
      );
}
