// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_catch_stack

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mien_spa_mobile/config/api_url.dart';

// 192.168.1.123
// 172.16.0.82
String baseUrl = ApiUrl.localhost;

class ApiClient {
  var client = http.Client();
  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl + api);
    var _headers = {
      'Content-Type': 'application/json',
    };
    var repone = await client.get(url, headers: _headers);
    if (repone.statusCode == 200 ||
        repone.statusCode == 201 ||
        repone.statusCode == 202) {
      return utf8.decode(repone.bodyBytes);
    } else {
      return null;
    }
  }

  Future<dynamic> post(String api, dynamic object) async {
    try {
      var url = Uri.parse(baseUrl + api);
      var _payload = json.encode(object);
      var _headers = {
        'Content-Type': 'application/json',
      };
      var repone = await client.post(url, body: _payload, headers: _headers);
      if (repone.statusCode == 200 ||
          repone.statusCode == 201 ||
          repone.statusCode == 202) {
        return utf8.decode(repone.bodyBytes);
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      return null;
    }
  }

  Future<dynamic> postString(String api, dynamic object) async {
    try {
      var url = Uri.parse(baseUrl + api);
      var _payload = object;
      var _headers = {
        'Content-Type': 'application/json',
      };
      var repone = await client.post(url, body: _payload, headers: _headers);
      if (repone.statusCode == 200 ||
          repone.statusCode == 201 ||
          repone.statusCode == 202) {
        return utf8.decode(repone.bodyBytes);
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      return null;
    }
  }

  Future<dynamic> put(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);
    var _headers = {
      'Content-Type': 'application/json',
    };
    var repone = await client.put(url, body: _payload, headers: _headers);
    if (repone.statusCode == 200 ||
        repone.statusCode == 201 ||
        repone.statusCode == 202) {
      return utf8.decode(repone.bodyBytes);
    } else {
      return null;
    }
  }

  Future<dynamic> delete(String api) async {
    var url = Uri.parse(baseUrl + api);
    var _headers = {
      'Content-Type': 'application/json',
    };
    var repone = await client.delete(url, headers: _headers);
    if (repone.statusCode == 200 ||
        repone.statusCode == 201 ||
        repone.statusCode == 202) {
      return utf8.decode(repone.bodyBytes);
    } else {
      return null;
    }
  }
}
