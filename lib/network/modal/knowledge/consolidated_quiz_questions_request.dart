class ConsolidatedQuizQuestions {
/*
*
* {
    "userid": {{userID}},
    "categoryid": 391,
    "IsSubmitAnswers": true,
    "submitAnswers": []
}
*
* */
  int categoryId;
  bool isSubmitAnswers;
  int userId;
  List<dynamic> submitAnswers;

  ConsolidatedQuizQuestions(
      {required this.categoryId,
      required this.userId,
      this.isSubmitAnswers = false,
      this.submitAnswers = const []});

  Map<String, dynamic> toJson() => {
        "categoryid": categoryId,
        "userid": userId,
        "IsSubmitAnswers": isSubmitAnswers,
        "submitAnswers": submitAnswers,
      };
}
