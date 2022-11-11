import 'package:get/get.dart';
import 'package:migo/models/notification/notification_model.dart' as noti;
import 'package:migo/service/notification_service.dart';

class NotificationController extends GetxController {
  late final NotificationService _notificationService;
  var isLoading = true.obs;
  var notificationList = <noti.Notification>[].obs;

  @override
  void onInit() {
    super.onInit();
    _notificationService = Get.put(NotificationService());
  }

  void fetchAllProducts() async {
    try {
      isLoading(true);
      var notifications = await _notificationService.fetchAllNotification();
      if (notifications != null) {
        notificationList.value = notifications;
      }
    } finally {
      isLoading(false);
    }
  }

  void deleteNotification(int index) {
    //TODO: Add notification deleteion function here
    Get.snackbar(
      "deleted",
      notificationList[index].description!,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
