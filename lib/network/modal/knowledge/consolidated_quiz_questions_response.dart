class ConsolidatedQuizQuestionsResponse {
  ConsolidatedQuizQuestionsResponse({
    this.categoryId = -1,
    this.quizResponse,
  });

  int categoryId;
  List<QuizResponseElement>? quizResponse;

  factory ConsolidatedQuizQuestionsResponse.fromJson(
          Map<String, dynamic> json) =>
      ConsolidatedQuizQuestionsResponse(
        categoryId: json["categoryid"] ?? -1,
        quizResponse: json["quizResponse"] == null
            ? null
            : List<QuizResponseElement>.from(json["quizResponse"]
                .map((x) => QuizResponseElement.fromJson(x))),
      );
}

class QuizResponseElement {
  QuizResponseElement(
      {this.questionId = -1,
      this.question = '',
      this.questionType = '',
      this.noOfQuestion = 0,
      this.answers,
      this.status = false,
      this.message = '',
      this.feedback = '',
      this.mediaUrl = '',
      this.quizEnd = false,
      this.quizScore = -1,
      this.correctAnswersList,
      this.groupValue = ''});

  int questionId;
  String question;
  String questionType;
  int noOfQuestion;
  List<AnswerElement>? answers;
  bool status;
  String message;
  String feedback;
  String mediaUrl;
  bool quizEnd;
  int quizScore;
  List<CorrectAnswersElement>? correctAnswersList;
  String groupValue;

  void setGroupValue(String value) {
    groupValue = value;
  }

  String getGroupValue() => groupValue;

  factory QuizResponseElement.fromJson(Map<String, dynamic> json) =>
      QuizResponseElement(
        questionId: json["questionid"] = -1,
        question: json["question"] ?? '',
        questionType: json["questiontype"] ?? '',
        noOfQuestion: json["noofquestion"] ?? 0,
        answers: json["answers"] == null
            ? null
            : List<AnswerElement>.from(
                json["answers"].map((x) => AnswerElement.fromJson(x))),
        status: json["status"] ?? false,
        message: json["message"] ?? '',
        feedback: json["feedback"] ?? '',
        mediaUrl: json["mediaurl"] ?? '',
        quizEnd: json["quizend"] ?? false,
        quizScore: json["quizscore"] ?? -1,
        correctAnswersList: json["CorrectAnswersList"] == null
            ? null
            : List<CorrectAnswersElement>.from(json["CorrectAnswersList"]
                .map((x) => CorrectAnswersElement.fromJson(x))),
      );
}

class AnswerElement {
  AnswerElement({this.answerNo = -1, this.answer,this.isSelected = false});

  int answerNo;
  dynamic answer;
  bool isSelected;

  factory AnswerElement.fromJson(Map<String, dynamic> json) => AnswerElement(
        answerNo: json["answerno"] ?? -1,
        answer: json["answer"] ?? '',
      );

  void setSelected(bool value) {
    isSelected = value;
  }

  bool getSelectedValue() => isSelected;
}

class CorrectAnswersElement {
  CorrectAnswersElement({
    this.correctAnswerNumber = -1,
    this.correctAnswer,
  });

  int correctAnswerNumber;
  dynamic correctAnswer;

  factory CorrectAnswersElement.fromJson(Map<String, dynamic> json) =>
      CorrectAnswersElement(
        correctAnswerNumber: json["CorrectAnswerNumber"] ?? -1,
        correctAnswer: json["CorrectAnswer"] ?? '',
      );
}
