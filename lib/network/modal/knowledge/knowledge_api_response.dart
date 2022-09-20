class KnowledgeApiResponse {
  KnowledgeApiResponse({
    this.knowledgeElement,
    this.status = false,
    this.message = '',
  });

  List<KnowledgeElement>? knowledgeElement;
  bool status;
  String message;

  factory KnowledgeApiResponse.fromJson(Map<String, dynamic> json) =>
      KnowledgeApiResponse(
        knowledgeElement: json["folder"] == null
            ? null
            : List<KnowledgeElement>.from(
                json["folder"].map((x) => KnowledgeElement.fromJson(x))),
        status: json["status"] ?? false,
        message: json["message"] ?? '',
      );
}

class KnowledgeElement {
  KnowledgeElement({
    this.folderId = 0,
    this.folderName = '',
    this.folderDescription = '',
    this.passCode = '',
    this.colourCode = '',
    this.thumbnailImage = '',
    this.isFolderRead = false,
  });

  int folderId;
  String folderName;
  String folderDescription;
  String passCode;
  String colourCode;
  String thumbnailImage;
  bool isFolderRead;

  factory KnowledgeElement.fromJson(Map<String, dynamic> json) =>
      KnowledgeElement(
        folderId: json["folderID"] ?? 0,
        folderName: json["folderName"] ?? '',
        folderDescription: json["folderDescription"] ?? '',
        passCode: json["passCode"] ?? '',
        colourCode: json["colourCode"] ?? '',
        thumbnailImage: json["thubnailImage"] ?? '',
        isFolderRead: json["isFolderRead"] ?? false,
      );
}
