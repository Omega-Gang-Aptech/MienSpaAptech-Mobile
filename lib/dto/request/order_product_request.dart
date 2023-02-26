import 'dart:convert';

OrderProductRequest orderProductRequestFromJson(String str) =>
    OrderProductRequest.fromJson(json.decode(str));

String orderProductRequestToJson(OrderProductRequest data) =>
    json.encode(data.toJson());

class OrderProductRequest {
  OrderProductRequest({
    this.createdAt,
    this.listProId,
    this.orProAddress,
    this.orProDob,
    this.orProId,
    this.orProNote,
    this.orProPayStatus,
    this.orProPayment,
    this.orProPhoneNo,
    this.orProShip,
    this.orProStatus,
    this.orProTotal,
    this.orProUserId,
    this.orProUserName,
    this.updatedAt,
  });

  dynamic createdAt;
  List<ListProId>? listProId;
  String? orProAddress;
  String? orProDob;
  String? orProId;
  String? orProNote;
  String? orProPayStatus;
  String? orProPayment;
  String? orProPhoneNo;
  int? orProShip;
  String? orProStatus;
  int? orProTotal;
  String? orProUserId;
  String? orProUserName;
  dynamic updatedAt;

  factory OrderProductRequest.fromJson(Map<String, dynamic> json) =>
      OrderProductRequest(
        createdAt: json["createdAt"],
        listProId: List<ListProId>.from(
            json["listProId"].map((x) => ListProId.fromJson(x))),
        orProAddress: json["orProAddress"],
        orProDob: json["orProDob"],
        orProId: json["orProId"],
        orProNote: json["orProNote"],
        orProPayStatus: json["orProPayStatus"],
        orProPayment: json["orProPayment"],
        orProPhoneNo: json["orProPhoneNo"],
        orProShip: json["orProShip"],
        orProStatus: json["orProStatus"],
        orProTotal: json["orProTotal"],
        orProUserId: json["orProUserId"],
        orProUserName: json["orProUserName"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "listProId": List<dynamic>.from(listProId!.map((x) => x.toJson())),
        "orProAddress": orProAddress,
        "orProDob": orProDob,
        "orProId": orProId,
        "orProNote": orProNote,
        "orProPayStatus": orProPayStatus,
        "orProPayment": orProPayment,
        "orProPhoneNo": orProPhoneNo,
        "orProShip": orProShip,
        "orProStatus": orProStatus,
        "orProTotal": orProTotal,
        "orProUserId": orProUserId,
        "orProUserName": orProUserName,
        "updatedAt": updatedAt,
      };
}

class ListProId {
  ListProId({
    required this.ordProQuantity,
    required this.productId,
  });

  int ordProQuantity;
  String productId;

  factory ListProId.fromJson(Map<String, dynamic> json) => ListProId(
        ordProQuantity: json["ordProQuantity"],
        productId: json["productId"],
      );

  Map<String, dynamic> toJson() => {
        "ordProQuantity": ordProQuantity,
        "productId": productId,
      };
}
