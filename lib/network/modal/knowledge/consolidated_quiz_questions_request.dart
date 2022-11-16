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
  List<SubmitAnswerElement> submitAnswers;

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

class SubmitAnswerElement {
  String questionId;
  String answerSubmitted;
  String attemptedQuestions;

//  {
//"questionid":3208,
//"answersubmited": "1",
// "attemptedQuestions":"0"

  SubmitAnswerElement({
    this.questionId = '',
    this.answerSubmitted = '',
    this.attemptedQuestions = '',
  });

  Map<String, dynamic> toJson() => {
        "questionid": questionId,
        "answersubmited": answerSubmitted,
        "attemptedQuestions": attemptedQuestions,
      };
}
