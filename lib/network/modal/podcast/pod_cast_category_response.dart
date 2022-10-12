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
    this.podCastCategory = '',
    this.categoryThumbnailImage = '',
    this.hasViewed = false,
  });

  int podCastCategoryId;
  String podCastCategory;
  String categoryThumbnailImage;
  bool hasViewed;

  factory PodCastCategoryElement.fromJson(Map<String, dynamic> json) =>
      PodCastCategoryElement(
        podCastCategoryId: json["podcastcategoryid"] ?? -1,
        podCastCategory: json["podcastcategory"] ?? '',
        categoryThumbnailImage: json["categorythumbnelimage"] ?? '',
        hasViewed: json["hasviewed"] ?? false,
      );
}
