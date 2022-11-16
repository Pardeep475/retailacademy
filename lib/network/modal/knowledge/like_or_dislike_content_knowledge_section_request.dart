class LikeOrDislikeContentKnowledgeSectionRequest {
  int fileId;
  int userId;
  int check;

  LikeOrDislikeContentKnowledgeSectionRequest(
      {required this.fileId, required this.userId, required this.check});

  Map<String, dynamic> toJson() => {
        "fileid": fileId,
        "userid": userId,
        "check": check,
      };

// {
// "fileid": 588,
// "userid": 16686,
// "check": 1
// }
}
