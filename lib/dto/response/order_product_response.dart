import 'dart:convert';

List<OrderProductReponse> orderProductReponseFromJson(String str) =>
    List<OrderProductReponse>.from(
        json.decode(str).map((x) => OrderProductReponse.fromJson(x)));

String orderProductReponseToJson(List<OrderProductReponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderProductReponse {
  OrderProductReponse({
    this.createdAt,
    required this.listProId,
    required this.orProAddress,
    required this.orProDob,
    required this.orProId,
    this.orProNote,
    required this.orProPayStatus,
    required this.orProPayment,
    required this.orProPhoneNo,
    required this.orProShip,
    required this.orProStatus,
    required this.orProTotal,
    required this.orProUserId,
    required this.orProUserName,
    this.updatedAt,
  });

  dynamic createdAt;
  List<ListProId> listProId;
  String orProAddress;
  String orProDob;
  String orProId;
  String? orProNote;
  String orProPayStatus;
  String orProPayment;
  String orProPhoneNo;
  int orProShip;
  String orProStatus;
  int orProTotal;
  String orProUserId;
  String orProUserName;
  dynamic updatedAt;

  factory OrderProductReponse.fromJson(Map<String, dynamic> json) =>
      OrderProductReponse(
        createdAt: json["createdAt"],
        listProId: json["listProId"] != null
            ? new List<ListProId>.from(
                json["listProId"].map((x) => ListProId.fromJson(x)))
            : <ListProId>[],
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
        "listProId": List<dynamic>.from(listProId.map((x) => x.toJson())),
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
