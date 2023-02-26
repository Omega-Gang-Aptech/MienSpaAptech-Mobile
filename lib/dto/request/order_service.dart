import 'dart:convert';

OrderSerceRequest orderSerceRequestFromJson(String str) =>
    OrderSerceRequest.fromJson(json.decode(str));

String orderSerceRequestToJson(OrderSerceRequest data) =>
    json.encode(data.toJson());

class OrderSerceRequest {
  OrderSerceRequest({
    this.createdAt,
    required this.listSerId,
    this.orSerEndTime,
    this.orSerId,
    this.orSerPhoneNo,
    this.orSerStartTime,
    this.orSerStatus,
    this.orSerUserId,
    this.orSerTotal,
    this.updatedAt,
  });

  dynamic createdAt;
  List<String> listSerId;
  String? orSerEndTime;
  String? orSerId;
  String? orSerPhoneNo;
  String? orSerStartTime;
  String? orSerStatus;
  String? orSerUserId;
  int? orSerTotal;
  dynamic updatedAt;

  factory OrderSerceRequest.fromJson(Map<String, dynamic> json) =>
      OrderSerceRequest(
        createdAt: DateTime.parse(json["createdAt"]),
        listSerId: List<String>.from(json["listSerId"].map((x) => x)),
        orSerEndTime: json["orSerEndTime"],
        orSerId: json["orSerId"],
        orSerPhoneNo: json["orSerPhoneNo"],
        orSerStartTime: json["orSerStartTime"],
        orSerStatus: json["orSerStatus"],
        orSerUserId: json["orSerUserId"],
        orSerTotal: json["orSer_Total"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "listSerId": List<dynamic>.from(listSerId.map((x) => x)),
        "orSerEndTime": orSerEndTime,
        "orSerId": orSerId,
        "orSerPhoneNo": orSerPhoneNo,
        "orSerStartTime": orSerStartTime,
        "orSerStatus": orSerStatus,
        "orSerUserId": orSerUserId,
        "orSer_Total": orSerTotal,
        "updatedAt": updatedAt,
      };
}
