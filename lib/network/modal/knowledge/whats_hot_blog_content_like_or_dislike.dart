class WhatsHotBlogContentLikeOrDisLikeRequest {

  int blogId;
  int userId;

  WhatsHotBlogContentLikeOrDisLikeRequest(
      { required this.userId,required this.blogId});

  Map<String, dynamic> toJson() => {
    "userid": userId,
    "blogid": blogId,
  };
}
