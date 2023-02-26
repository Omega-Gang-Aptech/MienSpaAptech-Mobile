import 'dart:convert';

ValidateOpt validateOptFromJson(String str) =>
    ValidateOpt.fromJson(json.decode(str));

String validateOptToJson(ValidateOpt data) => json.encode(data.toJson());

class ValidateOpt {
  ValidateOpt({
    required this.email,
    required this.otp,
  });

  String email;
  String otp;

  factory ValidateOpt.fromJson(Map<String, dynamic> json) => ValidateOpt(
        email: json["email"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "otp": otp,
      };
}
