class DeleteKnowledgeContentRequest {
  // {
  // "userid": {{userID}},
  // "commentid": 12736,
  // "fileid": 100
  // }

  final int userId;
  final int commentId;
  final int fileId;

  DeleteKnowledgeContentRequest(
      {required this.userId, required this.commentId, required this.fileId});

  Map<String, dynamic> toJson() => {
        "fileid": fileId,
        "userid": userId,
        "commentid": commentId,
      };
}
