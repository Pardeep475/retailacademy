class ContentKnowledgeResponse {
  ContentKnowledgeResponse({
    this.files,
    this.status = false,
    this.message = '',
  });

  List<FileElement>? files;
  bool status;
  String message;

  factory ContentKnowledgeResponse.fromJson(Map<String, dynamic> json) => ContentKnowledgeResponse(
    files: json["files"] == null ? null : List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
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
    this.fileSize = '',
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
  String fileSize;
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
    fileSize: json["filesize"] ?? '',
    hasTags: json["hastags"] ?? false,
    hasRead: json["hasread"] ?? false,
  );

}