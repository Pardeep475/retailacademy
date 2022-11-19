class InfoSessionRegistrationRequest {
  String webinarMeetingId;
  String userId;

  InfoSessionRegistrationRequest({required this.webinarMeetingId,required this.userId});

  Map<String, dynamic> toJson() => {
    "webinarMeetingId": webinarMeetingId,
    "userId": userId,
  };
}