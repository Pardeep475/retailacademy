import 'package:flutter/material.dart';

class PodCastCategoryResponse {
  PodCastCategoryResponse({
    this.podCastCategoryList,
    this.status = false,
    this.message = '',
  });

  List<PodCastCategoryElement>? podCastCategoryList;
  bool status;
  String message;

  factory PodCastCategoryResponse.fromJson(Map<String, dynamic> json) =>
      PodCastCategoryResponse(
        podCastCategoryList: json["podacastcategorylist"] == null
            ? null
            : List<PodCastCategoryElement>.from(json["podacastcategorylist"]
                .map((x) => PodCastCategoryElement.fromJson(x))),
        status: json["status"] ?? false,
        message: json["message"] ?? '',
      );
}

class PodCastCategoryElement {
  PodCastCategoryElement({
    this.podCastCategoryId = -1,
    this.podCastCategoryTitle = '',
    this.podCastCategoryDescription = '',
    this.categoryThumbnailImage = '',
    this.hasViewed = false,
    this.color = const Color(0xffFCED22),
  });

  int podCastCategoryId;
  String podCastCategoryTitle;
  String podCastCategoryDescription;
  String categoryThumbnailImage;
  bool hasViewed;
  Color color;

  factory PodCastCategoryElement.fromJson(Map<String, dynamic> json) =>
      PodCastCategoryElement(
        podCastCategoryId: json["podcastcategoryid"] ?? -1,
        podCastCategoryTitle: json["podcastcategory"] ?? '',
        podCastCategoryDescription: json["podcastDescription"] ?? '',
        categoryThumbnailImage: json["categorythumbnelimage"] ?? '',
        hasViewed: json["hasviewed"] ?? false,
      );
}
