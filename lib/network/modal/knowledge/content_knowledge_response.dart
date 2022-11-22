class ContentKnowledgeResponse {
  ContentKnowledgeResponse({
    this.files,
    this.status = false,
    this.message = '',
  });

  List<FileElement>? files;
  bool status;
  String message;

  factory ContentKnowledgeResponse.fromJson(Map<String, dynamic> json) =>
      ContentKnowledgeResponse(
        files: json["files"] == null
            ? null
            : List<FileElement>.from(
                json["files"].map((x) => FileElement.fromJson(x))),
        status: json["status"] ?? false,
        message: json["message"] ?? '',
      );
}

class FileElement {
  FileElement({
    this.fileId = 0,
    this.type = '',
    this.description = '',
    this.fileName = '',
    this.passCode = '',
    this.modifiedDate = '',
    this.filesUrl = '',
    this.thumbnailImage = '',
    this.fileSize = '',
    this.quizId = 0,
    this.quizName = '',
    this.hasTags = false,
    this.hasRead = false,
  });

  int fileId;
  String type;
  String description;
  String fileName;
  String passCode;
  String modifiedDate;
  String filesUrl;
  String thumbnailImage;
  String fileSize;
  int quizId;
  String quizName;
  bool hasTags;
  bool hasRead;

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        fileId: json["fileid"] ?? 0,
        type: json["type"] ?? '',
        description: json["description"] ?? '',
        fileName: json["filesname"] ?? '',
        passCode: json["passCode"] ?? '',
        modifiedDate: json["modifieddate"] ?? '',
        filesUrl: json["filesurl"] ?? '',
        thumbnailImage: json["thumbnaiImage"] ?? '',
        fileSize: json["filesize"] ?? '',
        quizId: json["quizid"] ?? 0,
        quizName: json["quizname"] ?? '',
        hasTags: json["hastags"] ?? false,
        hasRead: json["hasread"] ?? false,
      );
}
