class TrendingCommentRequest {
//  {
//     "activityStreamId": 1242,
//     "comment": "",
//     "lastcommentid": 0,
//     "userId": {{userID}},
//     "file": "",
//     "filename": "Nagraju7mayTest1104",
//     "extension": ".jpg",
//     "afterdate": ""
// }

  TrendingCommentRequest({
    this.activityStreamId = 0,
    this.lastCommentId = 0,
    this.userid = "",
    this.comment = "",
    this.afterDate = "",
    this.file = "",
    this.filename = "",
    this.extension = "",
  });

  int activityStreamId;
  String userid;
  String comment;
  String afterDate;
  int lastCommentId;
  String file;
  String filename;
  String extension;

  Map<String, dynamic> toJson() => {
        "activityStreamId": activityStreamId,
        "lastcommentid": lastCommentId,
        "userid": userid,
        "comment": comment,
        "afterdate": afterDate,
        "file": file,
        "filename": filename,
        "extension": extension,
      };
}
