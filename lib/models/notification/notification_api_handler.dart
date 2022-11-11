import 'package:migo/models/notification/notification_model.dart';

class NotificationAPIHandler {
  int? count;
  int? next;
  int? previous;
  List<Notification>? results;

  NotificationAPIHandler({this.count, this.next, this.previous, this.results});

  NotificationAPIHandler.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Notification>[];
      json['results'].forEach((v) {
        results!.add(Notification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<Notification>? getAllNotifications() {
    return results;
  }
}
