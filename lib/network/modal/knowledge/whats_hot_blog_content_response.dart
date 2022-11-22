class WhatsHotBlogContentResponse {
  WhatsHotBlogContentResponse({
    this.blogContentList,
    this.status = false,
    this.message = '',
  });

  List<BlogContentElement>? blogContentList;
  bool status;
  String message;

  factory WhatsHotBlogContentResponse.fromJson(Map<String, dynamic> json) =>
      WhatsHotBlogContentResponse(
        blogContentList: json["blog"] == null
            ? null
            : List<BlogContentElement>.from(
                json["blog"].map((x) => BlogContentElement.fromJson(x))),
        status: json["status"] ?? false,
        message: json["message"] ?? '',
      );
}

class BlogContentElement {
  BlogContentElement({
    this.blogId = -1,
    this.blogTitle = '',
    this.blogDescription = '',
    this.imageUrl = '',
    this.thumbnailImage = '',
    this.videoUrl = '',
    this.date = '',
    this.likeCount = 0,
    this.commentCount = 0,
    this.hasLiked = false,
    this.hasViewed = false,
  });

  int blogId;
  String blogTitle;
  String blogDescription;
  String imageUrl;
  String thumbnailImage;
  String videoUrl;
  String date;
  int likeCount;
  int commentCount;
  bool hasLiked;
  bool hasViewed;

  factory BlogContentElement.fromJson(Map<String, dynamic> json) =>
      BlogContentElement(
        blogId: json["blogid"] ?? -1,
        blogTitle: json["blogtitle"] ?? '',
        blogDescription: json["blogdescription"] ?? '',
        imageUrl: json["imageurl"] ?? '',
        thumbnailImage: json["thumnailImage"] ?? '',
        videoUrl: json["videourl"] ?? '',
        date: json["date"] ?? '',
        likeCount: json["likecount"] ?? 0,
        commentCount: json["commnetcount"] ?? 0,
        hasLiked: json["hasliked"] ?? false,
        hasViewed: json["hasviewed"] ?? false,
      );
}
