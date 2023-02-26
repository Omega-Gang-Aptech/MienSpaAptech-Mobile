import 'dart:convert';

UserRespone userResponeFromJson(String str) =>
    UserRespone.fromJson(json.decode(str));

String userResponeToJson(UserRespone data) => json.encode(data.toJson());

class UserRespone {
  UserRespone({
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

  factory UserRespone.fromJson(Map<String, dynamic> json) => UserRespone(
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
        "createdAt": createdAt,
        "updatedAt": updatedAt,
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
