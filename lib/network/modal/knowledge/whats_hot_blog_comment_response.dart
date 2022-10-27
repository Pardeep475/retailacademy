class WhatsHotBlogCommentResponse {
  WhatsHotBlogCommentResponse({
    this.blogComments,
    this.commentCount = 0,
    this.status = false,
    this.message = '',
  });

  List<BlogCommentElement>? blogComments;
  int commentCount;
  bool status;
  String message;

  factory WhatsHotBlogCommentResponse.fromJson(Map<String, dynamic> json) =>
      WhatsHotBlogCommentResponse(
        blogComments: json["blogcomments"] == null
            ? null
            : List<BlogCommentElement>.from(json["blogcomments"]
                .map((x) => BlogCommentElement.fromJson(x))),
        commentCount: json["commentcount"] ?? 0,
        status: json["status"] ?? false,
        message: json["message"] ?? '',
      );
}

class BlogCommentElement {
  BlogCommentElement({
    this.commentId = -1,
    this.blogId = -1,
    this.userId = -1,
    this.comment = '',
    this.userName = '',
    this.profileImage = '',
    this.commentedDate = '',
  });

  int commentId;
  int blogId;
  int userId;
  String comment;
  String userName;
  String profileImage;
  String commentedDate;

  factory BlogCommentElement.fromJson(Map<String, dynamic> json) =>
      BlogCommentElement(
        commentId: json["commentid"] ?? -1,
        blogId: json["blogid"] ?? -1,
        userId: json["userid"] ?? -1,
        comment: json["comment"] ?? '',
        userName: json["username"] ?? '',
        profileImage: json["profileimage"] ?? '',
        commentedDate: json["commenteddate"] ?? '',
      );
}
