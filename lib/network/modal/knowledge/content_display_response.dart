
class ContentDisplayResponse {
  ContentDisplayResponse({
    this.folderName = '',
    this.fileName = '',
    this.modifiedDate = '',
    this.filesUrl = '',
    this.fileSize = '',
    this.hasTags = false,
    this.likeByUser = false,
    this.noOfLikes = 0,
    this.noOfComments = 0,
    this.bookmarkByUser = false,
    this.status = false,
    this.message = '',
  });

  String folderName;
  String fileName;
  String modifiedDate;
  String filesUrl;
  String fileSize;
  bool hasTags;
  bool likeByUser;
  int noOfLikes;
  int noOfComments;
  bool bookmarkByUser;
  bool status;
  String message;

  factory ContentDisplayResponse.fromJson(Map<String, dynamic> json) => ContentDisplayResponse(
    folderName: json["foldername"] ?? '',
    fileName : json["filename"] ?? '',
    modifiedDate: json["modifieddate"] ?? '',
    filesUrl: json["filesurl"] ?? '',
    fileSize: json["filesize"] ?? '',
    hasTags: json["hastags"] ?? false,
    likeByUser: json["likebyuser"] ?? false,
    noOfLikes: json["nooflikes"] ?? 0,
    noOfComments: json["noofcomments"] ?? 0,
    bookmarkByUser: json["bookmarkbyuser"] ?? false,
    status: json["status"] ?? false,
    message: json["message"] ?? '',
  );

}
