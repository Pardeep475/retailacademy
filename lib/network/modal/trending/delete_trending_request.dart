class DeleteTrendingRequest {
  /*
  * {
    "commentId": 1200,
    "userId": {{userID}},
    "activityStreamId": 0
}
  *
  * */

  final int commentId;
  final int userId;
  final int activityStreamId;

  DeleteTrendingRequest(
      {required this.commentId,
      required this.userId,
      required this.activityStreamId});

  Map<String, dynamic> toJson() => {
        "activityStreamId": activityStreamId,
        "userId": commentId,
        "commentId": commentId,
      };
}
