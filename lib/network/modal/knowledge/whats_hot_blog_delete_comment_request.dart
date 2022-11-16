class WhatsHotBlogDeleteCommentRequest {
  WhatsHotBlogDeleteCommentRequest({
    this.commentId = -1,
    this.userId = '',
    this.blogId = -1,
  });

  int commentId;
  String userId;
  int blogId;

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "userId": userId,
        "blogid": blogId,
      };
}
