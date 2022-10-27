class WhatsHotBlogCommentRequest {
  WhatsHotBlogCommentRequest({
    this.blogId = -1,
    this.blogPost = '',
    this.userId = '',
  });

  int blogId;
  String blogPost;
  String userId;

  Map<String, dynamic> toJson() => {
        "blogid": blogId,
        "blogpost": blogPost,
        "userid": userId,
      };
}
