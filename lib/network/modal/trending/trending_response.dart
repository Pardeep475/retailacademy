class TrendingResponse {
  TrendingResponse({
    this.activityStreams,
    this.message = '',
    this.status = false,
  });

  List<ActivityStream>? activityStreams;
  String message;
  bool status;

  factory TrendingResponse.fromJson(Map<String, dynamic> json) =>
      TrendingResponse(
        activityStreams: json["activityStreams"] == null
            ? null
            : List<ActivityStream>.from(
                json["activityStreams"].map((x) => ActivityStream.fromJson(x))),
        message: json["message"] ?? '',
        status: json["status"] ?? false,
      );
}

class ActivityStream {
  ActivityStream({
    this.activityStreamId = 0,
    this.activityStreamText = '',
    this.likeCount = 0,
    this.commentCount = 0,
    this.date = '',
    this.hasLiked = false,
    this.userName = '',
    this.profileImage = '',
    this.activityImage = '',
    this.contentFileId = 0,
    this.contentFileName = '',
    this.allocationPoints = 0,
  });

  int activityStreamId;
  String activityStreamText;
  int likeCount;
  int commentCount;
  String date;
  bool hasLiked;
  String userName;
  String profileImage;
  String activityImage;
  int contentFileId;
  String contentFileName;
  int allocationPoints;

  factory ActivityStream.fromJson(Map<String, dynamic> json) => ActivityStream(
        activityStreamId: json["activityStreamId"] ?? 0,
        activityStreamText: json["activityStreamText"] ?? '',
        likeCount: json["likeCount"] ?? 0,
        commentCount: json["commentCount"] ?? 0,
        date: json["date"] ?? '',
        hasLiked: json["hasLiked"] ?? false,
        userName: json["userName"] ?? '',
        profileImage: json["profileImage"] ?? '',
        activityImage: json["activityimage"] ?? '',
        contentFileId: json["contentFileId"] ?? 0,
        allocationPoints: json["allocationPoints"] ?? 0,
        contentFileName: json["contentFileName"] ?? '',
      );
}
