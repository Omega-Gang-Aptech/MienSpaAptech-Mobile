import 'dart:convert';

Booking bookingFromJson(String str) => Booking.fromJson(json.decode(str));

String bookingToJson(Booking data) => json.encode(data.toJson());

class Booking {
  Booking({
    required this.serviceId,
  });

  String serviceId;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        serviceId: json["serviceId"],
      );

  Map<String, dynamic> toJson() => {
        "serviceId": serviceId,
      };
}

List<BookingList> bookingListFromJson(String str) => List<BookingList>.from(
    json.decode(str).map((x) => BookingList.fromJson(x)));

String bookingListToJson(List<BookingList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingList {
  BookingList({
    required this.serviceId,
  });

  String serviceId;

  factory BookingList.fromJson(Map<String, dynamic> json) => BookingList(
        serviceId: json["serviceId"],
      );

  Map<String, dynamic> toJson() => {
        "serviceId": serviceId,
      };
}
