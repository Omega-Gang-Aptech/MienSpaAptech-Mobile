import 'dart:convert';

ChangePasswordRequest changePasswordRequestFromJson(String str) =>
    ChangePasswordRequest.fromJson(json.decode(str));

String changePasswordRequestToJson(ChangePasswordRequest data) =>
    json.encode(data.toJson());

class ChangePasswordRequest {
  ChangePasswordRequest({
    required this.newPassword,
    required this.oldPassword,
    required this.userId,
  });

  String newPassword;
  String oldPassword;
  String userId;

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      ChangePasswordRequest(
        newPassword: json["newPassword"],
        oldPassword: json["oldPassword"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "newPassword": newPassword,
        "oldPassword": oldPassword,
        "userId": userId,
      };
}
