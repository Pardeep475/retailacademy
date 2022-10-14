
class PodcastViewedByUserRequest {
  PodcastViewedByUserRequest({
    this.userid = '',
    this.podcastId = '',
    this.userSpentOnPodcast = '00:00',
  });

  String userid;
  String podcastId;
  String userSpentOnPodcast;

  Map<String, dynamic> toJson() => {
    "userid": userid,
    "podcastID": podcastId,
    "userSpentOnPodcast": userSpentOnPodcast,
  };
}
