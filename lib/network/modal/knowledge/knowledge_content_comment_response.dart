class KnowledgeContentCommentResponse {
  KnowledgeContentCommentResponse({
    this.commentElementList,
    this.commentCount = 0,
    this.message = '',
    this.status = false,
  });

  List<KnowledgeContentCommentElement>? commentElementList;
  int commentCount;
  String message;
  bool status;

  factory KnowledgeContentCommentResponse.fromJson(Map<String, dynamic> json) =>
      KnowledgeContentCommentResponse(
        commentElementList: json["comments"] == null
            ? null
            : List<KnowledgeContentCommentElement>.from(
            json["comments"].map((x) => KnowledgeContentCommentElement.fromJson(x))),
        commentCount: json["commentcount"] ?? 0,
        message: json["message"] ?? '',
        status: json["status"] ?? false,
      );
}

class KnowledgeContentCommentElement {
  KnowledgeContentCommentElement({
    this.commentId = 0,
    this.userId = 0,
    this.comment = '',
    this.userName = '',
    this.profileImage = '',
    this.commentedDate = '',
  });

  int commentId;
  int userId;
  String comment;
  String userName;
  String profileImage;
  String commentedDate;

  factory KnowledgeContentCommentElement.fromJson(Map<String, dynamic> json) => KnowledgeContentCommentElement(
    commentId: json["commentid"] ?? 0,
    userId: json["userid"] ?? 0,
    comment: json["Comment"] ?? '',
    userName: json["userfullname"] ?? '',
    profileImage: json["imageurl"] ?? '',
    commentedDate: json["dateofcomment"] ?? '',
  );
}
