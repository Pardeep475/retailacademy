class RetailReelsListResponse {
  RetailReelsListResponse({
    this.reel,
    this.status = false,
    this.message = '',
  });

  List<ReelElement>? reel;
  bool status;
  String message;

  factory RetailReelsListResponse.fromJson(Map<String, dynamic> json) =>
      RetailReelsListResponse(
        reel: json["reel"] == null
            ? null
            : List<ReelElement>.from(json["reel"].map((x) => ReelElement.fromJson(x))),
        status: json["status"] ?? false,
        message: json["message"] ?? '',
      );

}

class ReelElement {
  ReelElement({
    this.reelId = -1,
    this.reelName = '',
    this.reelCategoryId = -1,
    this.fileName = '',
    this.filePath = '',
    this.startDate = '',
    this.endDate = '',
    this.reelTag = '',
    this.userName = '',
    this.profileImage = '',
    this.likeCount = 0,
    this.commentCount = 0,
    this.hasLiked = false,
    this.hasViewed = false,
  });

  int reelId;
  String reelName;
  int reelCategoryId;
  String fileName;
  String filePath;
  String startDate;
  String endDate;
  String reelTag;
  String userName;
  String profileImage;
  int likeCount;
  int commentCount;
  bool hasLiked;
  bool hasViewed;

  factory ReelElement.fromJson(Map<String, dynamic> json) => ReelElement(
        reelId: json["reelid"] ?? -1,
        reelName: json["ReelName"],
        reelCategoryId: json["ReelCategoryID"] ?? -1,
        fileName: json["FileName"] ?? '',
        filePath: json["FilePath"] ?? '',
        startDate: json["StartDate"] ?? '',
        endDate: json["EndDate"] ?? '',
        reelTag: json["ReelTag"] ?? '',
        userName: json["UserName"] ?? '',
        profileImage: json["profileImage"] ?? '',
        likeCount: json["likecount"] ?? 0,
        commentCount: json["commnetcount"] ?? 0,
        hasLiked: json["hasliked"] ?? false,
        hasViewed: json["hasviewed"] ?? false,
      );
}
