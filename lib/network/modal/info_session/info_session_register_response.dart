class InfoSessionRegisterRespose {
  InfoSessionRegisterRespose({
    this.id,
    this.joinUrl,
    this.registrantId,
    this.startTime,
    this.topic,
    this.statusCode,
    this.message,
  });

  String? id;
  String? joinUrl;
  String? registrantId;
  DateTime? startTime;
  String? topic;
  String? statusCode;
  String? message;

  factory InfoSessionRegisterRespose.fromJson(Map<String, dynamic> json) =>
      InfoSessionRegisterRespose(
        id: json["id"],
        joinUrl: json["join_url"],
        registrantId: json["registrant_id"],
        startTime: DateTime.parse(json["start_time"]),
        topic: json["topic"],
        statusCode: json["statusCode"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "join_url": joinUrl,
        "registrant_id": registrantId,
        "start_time": startTime?.toIso8601String(),
        "topic": topic,
        "statusCode": statusCode,
        "Message": message,
      };
}
