class UpdateProfileImageRequest {
  UpdateProfileImageRequest({
    this.userid = '',
    this.base64Image = '',

  });

  String userid;
  String base64Image;

  Map<String, dynamic> toJson() => {
    "userid": userid,
    "imagebytes": base64Image,
  };
}