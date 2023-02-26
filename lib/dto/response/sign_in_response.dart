import 'dart:convert';

SignInReponse signInReponseFromJson(String str) =>
    SignInReponse.fromJson(json.decode(str));

String signInReponseToJson(SignInReponse data) => json.encode(data.toJson());

class SignInReponse {
  SignInReponse({
    required this.refreshToken,
    required this.id,
    required this.username,
    required this.email,
    required this.roles,
    required this.tokenType,
    required this.accessToken,
  });

  String refreshToken;
  String id;
  String username;
  String email;
  List<String> roles;
  String tokenType;
  String accessToken;

  factory SignInReponse.fromJson(Map<String, dynamic> json) => SignInReponse(
        refreshToken: json["refreshToken"],
        id: json["id"],
        username: json["username"],
        email: json["email"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        tokenType: json["tokenType"],
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "refreshToken": refreshToken,
        "id": id,
        "username": username,
        "email": email,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "tokenType": tokenType,
        "accessToken": accessToken,
      };
}
