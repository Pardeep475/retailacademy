class ContentKnowledgeRequest {
  int folderId;
  int userId;


  ContentKnowledgeRequest({required this.folderId, required this.userId});


  // {
  // "folderid":5,"userid":835
  // }

  Map<String, dynamic> toJson() => {
    "folderid": folderId,
    "userid": userId,
  };

}