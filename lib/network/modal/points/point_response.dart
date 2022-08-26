
class PointResponse {
  PointResponse({
    this.leaderBoardUserList,
    this.status = false,
    this.message = '',
  });

  List<LeaderBoardUserList>? leaderBoardUserList;
  bool status;
  String message;

  factory PointResponse.fromJson(Map<String, dynamic> json) => PointResponse(
        leaderBoardUserList: json["leaderBoardUserList"] == null
            ? null
            : List<LeaderBoardUserList>.from(json["leaderBoardUserList"]
                .map((x) => LeaderBoardUserList.fromJson(x))),
        status: json["status"] ?? false,
        message: json["message"] ?? '',
      );

}

class LeaderBoardUserList {
  LeaderBoardUserList({
    this.userId = 0,
    this.userName = '',
    this.profileImage = '',
    this.points = 0,
    this.userCategory = '',
  });

  int userId;
  String userName;
  String profileImage;
  int points;
  String userCategory;

  factory LeaderBoardUserList.fromJson(Map<String, dynamic> json) =>
      LeaderBoardUserList(
        userId: json["UserId"] ?? 0,
        userName: json["UserName"] ?? '',
        profileImage: json["ProfileImage"] ?? '',
        points: json["points"] ?? 0,
        userCategory: json["userCategory"] ?? '',
      );

}
