import 'dart:convert';

UserRequest userRequestFromJson(String str) =>
    UserRequest.fromJson(json.decode(str));

String userRequestToJson(UserRequest data) => json.encode(data.toJson());

class UserRequest {
  UserRequest({
    this.createdAt,
    this.updatedAt,
    this.usId,
    this.usUserName,
    this.usPassword,
    this.usDob,
    this.usAddress,
    this.usPhoneNo,
    this.usEmailNo,
    this.usImage,
    this.usNote,
    this.isAdmin,
    this.isDelete,
  });

  dynamic createdAt;
  dynamic updatedAt;
  String? usId;
  String? usUserName;
  String? usPassword;
  dynamic usDob;
  dynamic usAddress;
  String? usPhoneNo;
  String? usEmailNo;
  dynamic usImage;
  dynamic usNote;
  bool? isAdmin;
  dynamic isDelete;

  factory UserRequest.fromJson(Map<String, dynamic> json) => UserRequest(
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        usId: json["usId"],
        usUserName: json["usUserName"],
        usPassword: json["usPassword"],
        usDob: json["usDob"],
        usAddress: json["usAddress"],
        usPhoneNo: json["usPhoneNo"],
        usEmailNo: json["usEmailNo"],
        usImage: json["usImage"],
        usNote: json["usNote"],
        isAdmin: json["isAdmin"],
        isDelete: json["isDelete"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt":
            createdAt.toString() == "null" ? null : createdAt.toString(),
        "updatedAt":
            updatedAt.toString() == "null" ? null : updatedAt.toString(),
        "usId": usId,
        "usUserName": usUserName,
        "usPassword": usPassword,
        "usDob": usDob,
        "usAddress": usAddress,
        "usPhoneNo": usPhoneNo,
        "usEmailNo": usEmailNo,
        "usImage": usImage,
        "usNote": usNote,
        "isAdmin": isAdmin,
        "isDelete": isDelete,
      };
}
