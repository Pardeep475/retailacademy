class NotificationListResponse {
  NotificationListResponse({
    this.listNotification,
    this.status = false,
    this.message = '',
  });

  List<NotificationElement>? listNotification;
  bool status;
  String message;

  factory NotificationListResponse.fromJson(Map<String, dynamic> json) =>
      NotificationListResponse(
        listNotification: json["listNotificaiton"] == null
            ? null
            : List<NotificationElement>.from(
                json["listNotificaiton"]
                    .map((x) => NotificationElement.fromJson(x)),
              ),
        status: json["status"] ?? false,
        message: json["message"] ?? '',
      );
}

class NotificationElement {
  NotificationElement({
    this.id = 0,
    this.message = '',
    this.sendDate = '',
    this.moduleName = '',
    this.moduleId = 0,
    this.isRead = false,
    this.brandUid = '',
    this.brandName = '',
    this.fileName = '',
    this.modifiedDate = '',
    this.filesUrl = '',
    this.fileSize = '',
    this.hasTags = false,
    this.blogCategoryId = '',
  });

  int id;
  String message;
  String sendDate;
  String moduleName;
  int moduleId;
  bool isRead;
  String brandUid;
  String brandName;
  String fileName;
  String modifiedDate;
  String filesUrl;
  String fileSize;
  bool hasTags;
  String blogCategoryId;

  factory NotificationElement.fromJson(Map<String, dynamic> json) =>
      NotificationElement(
        id: json["Id"] ?? 0,
        message: json["message"] ?? '',
        sendDate: json["sendDate"] ?? '',
        moduleName: json["moduleName"] ?? '',
        moduleId: json["moduleId"] ?? 0,
        isRead: json["isRead"] ?? false,
        brandUid: json["brandguid"] ?? '',
        brandName: json["brandname"] ?? '',
        fileName: json["filename"] ?? '',
        modifiedDate: json["modifieddate"] ?? '',
        filesUrl: json["filesurl"] ?? '',
        fileSize: json["filesize"] ?? '',
        hasTags: json["hastags"] ?? false,
        blogCategoryId: json["blogcategoryid"] ?? "",
      );
}
