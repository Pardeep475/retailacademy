class WhatsHotBlogContentRequest {
  int categoryId;
  int? blogId;
  int userId;

  // {
  // "categoryid": 27,
  // "userid": {{userID}}
  //
  // }
  WhatsHotBlogContentRequest(
      {required this.categoryId, required this.userId, this.blogId});

  // {
  // "folderid":5,"userid":835
  // }

  Map<String, dynamic> toJson() => {
        "categoryid": categoryId,
        "userid": userId,
        if (blogId != null) "blogid": blogId,
      };
}
