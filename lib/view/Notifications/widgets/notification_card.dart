import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/controller/notification_controller.dart';

class NotificationCard extends StatelessWidget {
  final NotificationController notificationController;
  final int index;
  const NotificationCard({
    required this.notificationController,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var infoColor = "#90baf9";
    var warningColor = "#ffbc1f";
    var dangerColor = "#ff6262";
    var notificationColor = Color(
      int.parse(
        "0XFF${notificationController.notificationList[index].category!.replaceAll("#", "")}",
      ),
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (notificationController.notificationList[index].category!
                          .toLowerCase() ==
                      infoColor)
                    Icon(
                      Iconsax.info_circle,
                      color: notificationColor,
                    ),
                  if (notificationController.notificationList[index].category!
                          .toLowerCase() ==
                      warningColor)
                    Icon(
                      Iconsax.warning_2,
                      color: notificationColor,
                    ),
                  if (notificationController.notificationList[index].category!
                          .toLowerCase() ==
                      dangerColor)
                    Icon(
                      Iconsax.danger,
                      color: notificationColor,
                    ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notificationController
                                      .notificationList[index].category!
                                      .toLowerCase() ==
                                  infoColor
                              ? "Low Stock"
                              : notificationController
                                          .notificationList[index].category!
                                          .toLowerCase() ==
                                      warningColor
                                  ? "Seriously Low stock"
                                  : "Out of Stock",
                          style: const TextStyle(
                            color: Colors.white54,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              notificationController
                                      .notificationList[index].description ??
                                  "Description",
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              " - ${notificationController.notificationList[index].stockAmount!} left",
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                notificationController.deleteNotification(index);
                debugPrint(
                  "Deletion of this notification ${notificationController.notificationList[index].description}",
                );
              },
              icon: const Icon(Iconsax.tick_square),
            ),
          ],
        ),
      ),
    );
  }
}
