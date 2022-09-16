import 'dart:convert';

import 'package:get/get_connect/connect.dart' hide Response;
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:dio/dio.dart';
import '../models/authentication/login_request_model.dart';
import '../models/authentication/login_response_model.dart';

/// LoginService responsible to communicate with web-server
/// via authenticaton related APIs
class LoginService extends GetConnect {
  final String loginUrl =
      'https://backpos.herokuapp.com/api/v1/accounts/login/';
  Future<LoginResponseModel?> fetchLogin(LoginRequestModel model) async {
    var dio = Dio();
    Response response =
        await dio.post(loginUrl, data: json.encode(model.toJson()));
    if (response.statusCode == HttpStatus.ok) {
      return LoginResponseModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
