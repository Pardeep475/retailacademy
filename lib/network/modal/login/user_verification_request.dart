class UserVerificationRequest {
  String jwtToken;

  UserVerificationRequest({required this.jwtToken});

  Map<String, dynamic> toJson() => {
        "jwtToken": jwtToken,
      };
}
