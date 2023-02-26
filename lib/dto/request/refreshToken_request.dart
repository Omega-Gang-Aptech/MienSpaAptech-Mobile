// ignore_for_file: file_names

import 'dart:convert';

RefreshTokenRequest refreshTokenRequestFromJson(String str) =>
    RefreshTokenRequest.fromJson(json.decode(str));

String refreshTokenRequestToJson(RefreshTokenRequest data) =>
    json.encode(data.toJson());

class RefreshTokenRequest {
  RefreshTokenRequest({
    required this.refreshToken,
    required this.token,
  });

  String refreshToken;
  String token;

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      RefreshTokenRequest(
        refreshToken: json["refreshToken"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "refreshToken": refreshToken,
        "token": token,
      };
}
