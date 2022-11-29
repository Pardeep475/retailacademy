// SendMessagesToRetailTeam

class SendMessagesToRetailTeam {
  String userID;
  String subject;
  String body;

  SendMessagesToRetailTeam(
      {this.userID = '', this.subject = 'Help', required this.body});

  Map<String, dynamic> toJson() => {
        "userID": userID,
        "subject": subject,
        "body": body,
      };
}
/*{
    "userID" : "",
    "subject" : "Mail From SMTP Thruoght Web APi updated",
    "body": "Dynamicalluy send email configurations updated"
}*/
