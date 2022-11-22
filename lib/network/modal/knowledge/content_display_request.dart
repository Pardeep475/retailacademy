class ContentDisplayRequest {
  ContentDisplayRequest({
    this.fileId = -1,
    this.userId = -1,
    this.brandId = '9C63B29D-2CB5-4128-B6F3-7FA35780354D',
  });

  int fileId;
  int userId;
  String brandId;

  Map<String, dynamic> toJson() => {
        "fileid": fileId,
        "userid": userId,
        "brandid": brandId,
      };
}
