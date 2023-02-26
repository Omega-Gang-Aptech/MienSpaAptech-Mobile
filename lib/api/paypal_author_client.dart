// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class PaypalAuthorClient extends http.BaseClient {
  final String username;
  final String password;
  final http.Client _inner;
  final String _authString;

  PaypalAuthorClient(this.username, this.password, {http.Client? inner})
      : _authString = _getAuthString(username, password),
        _inner = inner ?? http.Client();

  static String _getAuthString(String username, String password) {
    final token = base64.encode(latin1.encode('$username:$password'));

    final authstr = 'Basic ' + token.trim();

    return authstr;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers['Authorization'] = _authString;

    return _inner.send(request);
  }

  @override
  void close() {
    _inner.close();
  }
}
