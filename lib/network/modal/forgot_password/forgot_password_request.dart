class ForgotPasswordRequest {
  String emailId;

  ForgotPasswordRequest({required this.emailId});

  Map<String, dynamic> toJson() => {
        "emailid": emailId,
      };
}
