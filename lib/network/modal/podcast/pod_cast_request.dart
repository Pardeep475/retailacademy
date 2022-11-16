class PodCastRequest {
  PodCastRequest({
    this.podcastCategoryId = -1,
    this.userId = '',
    this.podcastId = '',
  });

  int podcastCategoryId;
  String userId;
  String podcastId;

  Map<String, dynamic> toJson() => {
        "podcastCategoryid": podcastCategoryId,
        "userid": userId,
        "podcastid": podcastId,
      };
}
