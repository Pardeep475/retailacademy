
class InfoSessionResponse {
  InfoSessionResponse({
    this.sessionId = 0,
    this.sessionDescription = '',
    this.zoomMeetingLink = '',
    this.webinarId = '',
    this.password = '',
    this.zoomMeetingStartDate = '',
    this.zoomMeetingEndDate = '',
    this.allocationPoints = 0,
    this.isActive = false,
    this.status = false,
    this.message = '',
    this.meetingRecordedUrl = '',
    this.registrationStatus = false,
    this.zoomRegistrationId = '',
    this.playUrlPassword = '',
  });

  int sessionId;
  String sessionDescription;
  String zoomMeetingLink;
  String webinarId;
  String password;
  String zoomMeetingStartDate;
  String zoomMeetingEndDate;
  int allocationPoints;
  bool isActive;
  bool status;
  String message;
  String meetingRecordedUrl;
  bool registrationStatus;
  String zoomRegistrationId;
  String playUrlPassword;

  factory InfoSessionResponse.fromJson(Map<String, dynamic> json) => InfoSessionResponse(
    sessionId: json["sesssionId"] ?? 0,
    sessionDescription: json["sessionDescription"] ?? '',
    zoomMeetingLink: json["zoomMeetingLink"] ?? '',
    webinarId: json["webinarId"] ?? '',
    password: json["Password"] ?? '',
    zoomMeetingStartDate: json["zoomMeeetingStartDate"] ?? '',
    zoomMeetingEndDate: json["zoomMeeetingEndtDate"] ?? '',
    allocationPoints: json["allocationPoints"] ?? 0,
    isActive: json["isActive"] ?? false,
    status: json["status"] ?? false,
    message: json["message"] ?? '',
    meetingRecordedUrl: json["meetingRecordedUrl"] ?? '',
    registrationStatus: json["registrationStatus"] ?? false,
    zoomRegistrationId: json["zoomRegistrationID"] ?? '',
    playUrlPassword: json["playUrlPassword"] ?? '',
  );

}
