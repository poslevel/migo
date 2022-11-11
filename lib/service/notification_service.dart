import 'dart:convert';
import 'package:get/get_connect/connect.dart' hide Response;
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:dio/dio.dart';
import 'package:migo/models/cache.dart';
import 'package:migo/models/notification/notification_api_handler.dart';

import '../models/notification/notification_model.dart';

/// via authenticaton related APIs
class NotificationService extends GetConnect with CacheManager {
  final String notificationCreation =
      'https://backpos.herokuapp.com/api/v1/notification/';

  Future<List<Notification>?> fetchAllNotification() async {
    var dio = Dio();
    final token = getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    Response response = await dio.get(notificationCreation);
    if (response.statusCode == HttpStatus.ok) {
      NotificationAPIHandler handler =
          NotificationAPIHandler.fromJson(response.data);
      List<Notification>? notifications = handler.getAllNotifications();
      return notifications;
    } else {
      return null;
    }
  }
}
