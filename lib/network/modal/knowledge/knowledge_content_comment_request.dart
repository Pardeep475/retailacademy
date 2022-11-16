class KnowledgeContentCommentRequest {
//  {
//     "fileid": 1242,
//     "comment": "",
//     "lastcommentid": 0,
//     "userId": {{userID}},
//     "file": "",
//     "filename": "Nagraju7mayTest1104",
//     "extension": ".jpg",
//     "afterdate": ""
// }

  KnowledgeContentCommentRequest({
    this.fileId = 0,
    this.lastCommentId = 0,
    this.userid = "",
    this.comment = "",
    this.afterDate = "",
  });

  int fileId;
  String userid;
  String comment;
  String afterDate;
  int lastCommentId;

  Map<String, dynamic> toJson() => {
    "fileid": fileId,
    "lastcommentid": lastCommentId,
    "userid": userid,
    "comment": comment,
    "afterdate": afterDate,
  };
}
