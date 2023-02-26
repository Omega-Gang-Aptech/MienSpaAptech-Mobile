
import 'dart:convert';

List<OrderSerceResponse> orderSerceResponseFromJson(String str) =>
    List<OrderSerceResponse>.from(
        json.decode(str).map((x) => OrderSerceResponse.fromJson(x)));

String orderSerceResponseToJson(List<OrderSerceResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderSerceResponse {
  OrderSerceResponse({
    required this.createdAt,
    this.updatedAt,
    required this.orSerId,
    required this.orSerUserId,
    required this.orSerPhoneNo,
    required this.orSerStatus,
    required this.orSerStartTime,
    required this.orSerEndTime,
    required this.orSerTotal,
    required this.listSerId,
  });

  DateTime createdAt;
  dynamic updatedAt;
  String orSerId;
  String orSerUserId;
  String orSerPhoneNo;
  String orSerStatus;
  DateTime orSerStartTime;
  DateTime orSerEndTime;
  int orSerTotal;
  List<String> listSerId;

  factory OrderSerceResponse.fromJson(Map<String, dynamic> json) =>
      OrderSerceResponse(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"],
        orSerId: json["orSerId"],
        orSerUserId: json["orSerUserId"],
        orSerPhoneNo: json["orSerPhoneNo"],
        orSerStatus: json["orSerStatus"],
        orSerStartTime: DateTime.parse(json["orSerStartTime"]),
        orSerEndTime: DateTime.parse(json["orSerEndTime"]),
        orSerTotal: json["orSer_Total"],
        listSerId: List<String>.from(json["listSerId"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt,
        "orSerId": orSerId,
        "orSerUserId": orSerUserId,
        "orSerPhoneNo": orSerPhoneNo,
        "orSerStatus": orSerStatus,
        "orSerStartTime": orSerStartTime.toIso8601String(),
        "orSerEndTime": orSerEndTime.toIso8601String(),
        "orSer_Total": orSerTotal,
        "listSerId": List<dynamic>.from(listSerId.map((x) => x)),
      };
}
