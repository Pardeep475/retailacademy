class QuizCategoryResponse {
  QuizCategoryResponse({
    this.quizCategories,
    this.status = false,
    this.message = '',
  });

  List<QuizCategoryElement>? quizCategories;
  bool status;
  String message;

  factory QuizCategoryResponse.fromJson(Map<String, dynamic> json) =>
      QuizCategoryResponse(
        quizCategories: json["quizCategories"] == null
            ? null
            : List<QuizCategoryElement>.from(json["quizCategories"]
                .map((x) => QuizCategoryElement.fromJson(x))),
        status: json["status"] ?? false,
        message: json["message"] ?? '',
      );
}

class QuizCategoryElement {
  QuizCategoryElement({
    this.categoryId = -1,
    this.categoryName = '',
    this.categoryDescription = '',
    this.hasViewed = false,
    this.hasAttempted = false,
    this.isAttempted  = false,
  });

  int categoryId;
  String categoryName;
  String categoryDescription;
  bool hasViewed;
  bool hasAttempted;
  bool isAttempted;

  factory QuizCategoryElement.fromJson(Map<String, dynamic> json) =>
      QuizCategoryElement(
        categoryId: json["categoryID"] ?? -1,
        categoryName: json["categoryName"] ?? '',
        categoryDescription: json["categoryDescription"] ?? '',
        hasViewed: json["hasViewed"] ?? false,
        hasAttempted: json["hasattempted"] ?? false,
        isAttempted: json["isAttempted"] ?? false,
      );

}
