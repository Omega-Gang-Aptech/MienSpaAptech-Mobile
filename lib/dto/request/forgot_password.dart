import 'dart:convert';

ForgotpasswordRequest forgotpasswordRequestFromJson(String str) =>
    ForgotpasswordRequest.fromJson(json.decode(str));

String forgotpasswordRequestToJson(ForgotpasswordRequest data) =>
    json.encode(data.toJson());

class ForgotpasswordRequest {
  ForgotpasswordRequest({
    required this.email,
    required this.otp,
    required this.password,
  });

  String email;
  String otp;
  String password;

  factory ForgotpasswordRequest.fromJson(Map<String, dynamic> json) =>
      ForgotpasswordRequest(
        email: json["email"],
        otp: json["otp"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "otp": otp,
        "password": password,
      };
}
