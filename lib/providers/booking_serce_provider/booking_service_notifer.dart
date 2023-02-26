// ignore_for_file: prefer_const_constructors, unnecessary_new, depend_on_referenced_packages, prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mien_spa_mobile/api/api_client.dart';
import 'package:mien_spa_mobile/dto/response/serce_response.dart';
import 'package:mien_spa_mobile/models/booking.dart';
import 'package:collection/collection.dart';

final bookingNotifierProvider =
    ChangeNotifierProvider.autoDispose<BookingNotifier>(
  (ref) => BookingNotifier(),
);

class BookingNotifier extends ChangeNotifier {
  List<Booking> _booking = [];
  int sum = 0;
  final storage = new FlutterSecureStorage();
  Future<bool> addService(Booking booking) async {
    int sum = 0;
    if (await storage.read(key: "booking") != null) {
      var data = await storage.read(key: "booking");
      List<BookingList> list = bookingListFromJson(data!);
      for (var element in list) {
        Booking dataSerce = Booking(serviceId: element.serviceId);
        _booking.add(dataSerce);
      }
    }
    var checkProduct = _booking
        .firstWhereOrNull((element) => element.serviceId == booking.serviceId);
    if (checkProduct == null) {
      _booking.add(booking);
    } else {
      return false;
    }
    var data = await ApiClient().get("/api/Serce").catchError((err) {});
    if (data != null) {
      List<Serce> listSerce = serceFromJson(data);
      for (var element in listSerce) {
        for (var item in _booking) {
          if (element.seId == item.serviceId) {
            sum = sum + element.sePrice;
          }
        }
      }
    }
    await storage.write(key: "total_booking", value: sum.toString());
    await storage.write(key: "booking", value: json.encode(_booking.toList()));
    return true;
  }

  void removeService(Booking booking) async {
    int sum = 0;
    if (await storage.read(key: "booking") != null) {
      var data = await storage.read(key: "booking");
      List<BookingList> list = bookingListFromJson(data!);
      for (var element in list) {
        Booking dataSerce = Booking(serviceId: element.serviceId);
        _booking.add(dataSerce);
      }
    }
    _booking.removeWhere((c) => c.serviceId == booking.serviceId);
    var data = await ApiClient().get("/api/Serce").catchError((err) {});
    if (data != null) {
      List<Serce> listSerce = serceFromJson(data);
      for (var element in listSerce) {
        for (var item in _booking) {
          if (element.seId == item.serviceId) {
            sum = sum + element.sePrice;
          }
        }
      }
    }
    await storage.write(key: "total_booking", value: sum.toString());
    await storage.write(key: "booking", value: json.encode(_booking.toList()));
  }

  Future<dynamic> getCount() async {
    var b = await storage.read(key: "total_booking");
    if (b != null) {
      return b.toString();
    } else {
      return null;
    }
  }
}
