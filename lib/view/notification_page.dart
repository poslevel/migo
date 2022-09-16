import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/view/responsive.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

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
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 40,
            itemBuilder: (context, index) => const NotificationCard(),
          ),
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Iconsax.notification),
                SizedBox(width: 16),
                Text("This is a notification"),
              ],
            ),
            const Icon(Iconsax.tick_square)
          ],
        ),
      ),
    );
  }
}
