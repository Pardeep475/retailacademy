class PodCastResponse {
  PodCastResponse({
    this.podcasts,
    this.message = '',
    this.status = false,
  });

  List<PodcastElement>? podcasts;
  String message;
  bool status;

  factory PodCastResponse.fromJson(Map<String, dynamic> json) =>
      PodCastResponse(
        podcasts: json["podcasts"] == null
            ? null
            : List<PodcastElement>.from(
                json["podcasts"].map((x) => PodcastElement.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );
}

class PodcastElement {
  PodcastElement({
    this.podcastId = -1,
    this.podcastTitle = '',
    this.podcastDescription = '',
    this.podcastTag = '',
    this.likeCount = 0,
    this.commentCount = 0,
    this.podcastStartDate = '',
    this.podcastEndDate = '',
    this.userName = '',
    this.profileImage = '',
    this.hasLiked = false,
    this.hasViewed = false,
    this.podcastFile = '',
    this.podcastFileName = '',
    this.thumbnailPath = '',
  });

  int podcastId;
  String podcastTitle;
  String podcastDescription;
  String podcastTag;
  int likeCount;
  int commentCount;
  String podcastStartDate;
  String podcastEndDate;
  String userName;
  String profileImage;
  bool hasLiked;
  bool hasViewed;
  String podcastFile;
  String podcastFileName;
  String thumbnailPath;

  factory PodcastElement.fromJson(Map<String, dynamic> json) => PodcastElement(
        podcastId: json["podcastId"] ?? -1,
        podcastTitle: json["podcastTitle"] ?? '',
        podcastDescription: json["podcastDescription"] ?? '',
        podcastTag: json["podcastTag"] ?? "",
        likeCount: json["likeCount"] ?? 0,
        commentCount: json["commentCount"] ?? 0,
        podcastStartDate: json["podcastStartDate"] ?? '',
        podcastEndDate: json["podcastEndDate"] ?? "",
        userName: json["userName"] ?? '',
        profileImage: json["profileImage"] ?? '',
        hasLiked: json["hasLiked"] ?? false,
        hasViewed: json["hasViewed"] ?? false,
        podcastFile: json["podcastFile"] ?? '',
        podcastFileName: json["podcastFileName"] ?? '',
        thumbnailPath: json["ThumbnailPath"] ?? '',
      );
}
