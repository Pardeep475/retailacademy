class PodCastLikeRequest {
  PodCastLikeRequest({
    this.userId = '',
    this.podcastId = -1,
  });

  String userId;
  int podcastId;

  Map<String, dynamic> toJson() => {
        "userid": userId,
        "podcastid": podcastId,
      };
}
