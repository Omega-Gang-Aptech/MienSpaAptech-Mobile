// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors, unnecessary_new, unused_local_variable, prefer_interpolation_to_compose_strings, unused_import, depend_on_referenced_packages, deprecated_member_use

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mien_spa_mobile/api/api_client.dart';
import 'package:mien_spa_mobile/config/api_url.dart';
import 'package:mien_spa_mobile/dto/request/refreshToken_request.dart';
import 'package:mien_spa_mobile/dto/request/sign_in_request.dart';
import 'package:mien_spa_mobile/dto/response/sign_in_response.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

// 192.168.1.123
// 172.16.0.82
String baseUrl = ApiUrl.localhost;

class BaseAuthorClient {
  var client = http.Client();
  final storage = new FlutterSecureStorage();

  Future<dynamic> get(String api) async {
    var account = await storage.read(key: "api_account");
    var email = await storage.read(key: "email");
    var password = await storage.read(key: "password");

    if (account != null) {
      SignInReponse convertData = signInReponseFromJson(account);
      var url = Uri.parse(baseUrl + api);
      var _headers = {
        'Authorization': 'Bearer ' + convertData.accessToken,
        'Content-Type': 'application/json',
      };
      var repone = await client.get(url, headers: _headers);
      if (repone.statusCode == 200 ||
          repone.statusCode == 201 ||
          repone.statusCode == 202) {
        return utf8.decode(repone.bodyBytes);
      } else if (repone.statusCode == 404) {
        return null;
      } else if (repone.statusCode == 500) {
        return null;
      } else {
        var refreshToken = RefreshTokenRequest(
            refreshToken: convertData.refreshToken,
            token: convertData.accessToken);
        var refresh = await ApiClient()
            .post('/login/refreshtoken', refreshToken)
            .catchError((err) {});
        if (refresh != null) {
          convertData.accessToken = refreshToken.token;
          convertData.refreshToken = refreshToken.refreshToken;
          var convertToJson = signInReponseToJson(convertData);
          await storage.write(key: "api_account", value: convertToJson);
          var data = await storage.read(key: "api_account");
        } else {
          if (email != null && password != null) {
            var account = SignInRequest(email: email, password: password);
            var respone = await ApiClient()
                .post('/login/signin', account)
                .catchError((err) {});
            await storage.write(key: "api_account", value: respone);
            get(api);
          } else {
            return null;
          }
        }
      }
    }
  }

  Future<dynamic> post(String api, dynamic object) async {
    var account = await storage.read(key: "api_account");
    var email = await storage.read(key: "email");
    var password = await storage.read(key: "password");

    if (account != null) {
      SignInReponse convertData = signInReponseFromJson(account);
      var url = Uri.parse(baseUrl + api);
      var _payload = json.encode(object);
      var _headers = {
        'Authorization': 'Bearer ' + convertData.accessToken,
        'Content-Type': 'application/json',
      };
      var repone = await client.post(url, body: _payload, headers: _headers);
      if (repone.statusCode == 200 ||
          repone.statusCode == 201 ||
          repone.statusCode == 202) {
        return utf8.decode(repone.bodyBytes);
      } else if (repone.statusCode == 404) {
        return null;
      } else if (repone.statusCode == 500) {
        return null;
      } else {
        var refreshToken = RefreshTokenRequest(
            refreshToken: convertData.refreshToken,
            token: convertData.accessToken);
        var refresh = await ApiClient()
            .post('/login/refreshtoken', refreshToken)
            .catchError((err) {});
        if (refresh != null) {
          convertData.accessToken = refreshToken.token;
          convertData.refreshToken = refreshToken.refreshToken;
          var convertToJson = signInReponseToJson(convertData);
          await storage.write(key: "api_account", value: convertToJson);
          var data = await storage.read(key: "api_account");
        } else {
          if (email != null && password != null) {
            var account = SignInRequest(email: email, password: password);
            var respone = await ApiClient()
                .post('/login/signin', account)
                .catchError((err) {});
            await storage.write(key: "api_account", value: respone);
            post(api, object);
          } else {
            return null;
          }
        }
      }
    }
  }

  Future<dynamic> put(String api, dynamic object) async {
    var account = await storage.read(key: "api_account");
    var email = await storage.read(key: "email");
    var password = await storage.read(key: "password");

    if (account != null) {
      SignInReponse convertData = signInReponseFromJson(account);
      var url = Uri.parse(baseUrl + api);
      var _payload = json.encode(object);
      var _headers = {
        'Authorization': 'Bearer ' + convertData.accessToken,
        'Content-Type': 'application/json',
      };
      var repone = await client.put(url, body: _payload, headers: _headers);
      if (repone.statusCode == 200 ||
          repone.statusCode == 201 ||
          repone.statusCode == 202) {
        return utf8.decode(repone.bodyBytes);
      } else if (repone.statusCode == 404) {
        return null;
      } else if (repone.statusCode == 500) {
        return null;
      } else {
        var refreshToken = RefreshTokenRequest(
            refreshToken: convertData.refreshToken,
            token: convertData.accessToken);
        var refresh = await ApiClient()
            .post('/login/refreshtoken', refreshToken)
            .catchError((err) {});
        if (refresh != null) {
          convertData.accessToken = refreshToken.token;
          convertData.refreshToken = refreshToken.refreshToken;
          var convertToJson = signInReponseToJson(convertData);
          await storage.write(key: "api_account", value: convertToJson);
          var data = await storage.read(key: "api_account");
        } else {
          if (email != null && password != null) {
            var account = SignInRequest(email: email, password: password);
            var respone = await ApiClient()
                .post('/login/signin', account)
                .catchError((err) {});
            await storage.write(key: "api_account", value: respone);
            put(api, object);
          } else {
            return null;
          }
        }
      }
    }
  }

  Future<dynamic> delete(String api) async {
    var account = await storage.read(key: "api_account");
    var email = await storage.read(key: "email");
    var password = await storage.read(key: "password");

    if (account != null) {
      SignInReponse convertData = signInReponseFromJson(account);
      var url = Uri.parse(baseUrl + api);
      var _headers = {
        'Authorization': 'Bearer ' + convertData.accessToken,
        'Content-Type': 'application/json',
      };
      var repone = await client.delete(url, headers: _headers);
      if (repone.statusCode == 200 ||
          repone.statusCode == 201 ||
          repone.statusCode == 202) {
        return utf8.decode(repone.bodyBytes);
      } else if (repone.statusCode == 404) {
        return null;
      } else if (repone.statusCode == 500) {
        return null;
      } else {
        var refreshToken = RefreshTokenRequest(
            refreshToken: convertData.refreshToken,
            token: convertData.accessToken);
        var refresh = await ApiClient()
            .post('/login/refreshtoken', refreshToken)
            .catchError((err) {});
        if (refresh != null) {
          convertData.accessToken = refreshToken.token;
          convertData.refreshToken = refreshToken.refreshToken;
          var convertToJson = signInReponseToJson(convertData);
          await storage.write(key: "api_account", value: convertToJson);
          var data = await storage.read(key: "api_account");
        } else {
          if (email != null && password != null) {
            var account = SignInRequest(email: email, password: password);
            var respone = await ApiClient()
                .post('/login/signin', account)
                .catchError((err) {});
            await storage.write(key: "api_account", value: respone);
            get(api);
          } else {
            return null;
          }
        }
      }
    }
  }

  Future<dynamic> putForm(String api, dynamic object, dynamic file) async {
    var account = await storage.read(key: "api_account");
    var email = await storage.read(key: "email");
    var password = await storage.read(key: "password");

    if (account != null) {
      SignInReponse convertData = signInReponseFromJson(account);
      var url = Uri.parse(baseUrl + api);
      var request = new http.MultipartRequest("PUT", url);
      request.headers['Authorization'] = 'Bearer ' + convertData.accessToken;
      request.fields['data_json'] = object.toString();
      if (file != null) {
        var stream =
            new http.ByteStream(DelegatingStream.typed(file.openRead()));
        // get file length
        var length = await file.length();
        var multipartFileSign = new http.MultipartFile('file', stream, length,
            filename: basename(file.path));

        // add file to multipart
        request.files.add(multipartFileSign);
      }
      var reponse = await request.send();
      if (reponse.statusCode == 202 ||
          reponse.statusCode == 201 ||
          reponse.statusCode == 202) {
        return reponse.statusCode;
      } else if (reponse.statusCode == 404) {
        return null;
      } else if (reponse.statusCode == 500) {
        return null;
      } else {
        var refreshToken = RefreshTokenRequest(
            refreshToken: convertData.refreshToken,
            token: convertData.accessToken);
        var refresh = await ApiClient()
            .post('/login/refreshtoken', refreshToken)
            .catchError((err) {});
        if (refresh != null) {
          convertData.accessToken = refreshToken.token;
          convertData.refreshToken = refreshToken.refreshToken;
          var convertToJson = signInReponseToJson(convertData);
          await storage.write(key: "api_account", value: convertToJson);
          var data = await storage.read(key: "api_account");
        } else {
          if (email != null && password != null) {
            var account = SignInRequest(email: email, password: password);
            var respone = await ApiClient()
                .post('/login/signin', account)
                .catchError((err) {});
            await storage.write(key: "api_account", value: respone);
            get(api);
          } else {
            return null;
          }
        }
      }
    }
  }
}
