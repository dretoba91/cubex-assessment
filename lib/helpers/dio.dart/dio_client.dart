import 'dart:developer';

import 'package:dio/dio.dart';

class DioClient {
  final Dio dio = Dio();
  static const baseUrl = "https://stacked.com.ng";

  Future<dynamic> register(
    String email,
    String username,
    String password,
    String phoneNumber,
    String avatar,
  ) async {
    Map<String, dynamic> body = {};

    body = {
      "username": username,
      "password": password,
      "email": email,
      "phone": phoneNumber,
      "address": "string",
      "image": "string",
    };
    if (avatar != '') {
      body["image"] = avatar;
    } else {
      body["image"] = "string";
    }

    log("==> body: $body");

    String url = "/api/register";

    var response = await dio.post(baseUrl + url, data: body);

    return response.data;
  }

  Future<dynamic> login(username, password) async {
    Map<String, dynamic> body = {};
    body = {
      "username": username,
      "password": password,
    };

    String url = "/api/login";

    var response = await dio.post(baseUrl + url, data: body);
    return response.data;
  }

  Future<dynamic> getUser() async {
    String url = "/api/profile";
    var response = await dio.get(baseUrl + url);
    return response.data;
  }
}
