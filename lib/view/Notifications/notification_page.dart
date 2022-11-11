import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:migo/controller/notification_controller.dart';
import 'package:migo/view/notifications/widgets/notification_card.dart';
import 'package:migo/view/responsive.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final NotificationController notificationController =
      Get.put(NotificationController());
  @override
  void initState() {
    notificationController.fetchAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Notifications",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Responsive.isMobile(context) ? 24 : 36,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.isDesktop(context)
                ? 128
                : Responsive.isTablet(context)
                    ? 72
                    : 16,
          ),
          child: Obx(() {
            if (notificationController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: notificationController.notificationList.length,
                itemBuilder: (context, index) => NotificationCard(
                  notificationController: notificationController,
                  index: index,
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
