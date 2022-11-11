import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/models/authManager.dart';
import 'package:migo/utils/functions.dart';
import 'package:migo/view/Notifications/notification_page.dart';

import 'package:migo/view/responsive.dart';

class TopAppBar extends StatefulWidget {
  const TopAppBar({Key? key, required this.pageName}) : super(key: key);

  final String pageName;
  @override
  State<TopAppBar> createState() => _TopAppBarState();
}

class _TopAppBarState extends State<TopAppBar> {
  final AuthenticationManager _authManager = Get.find();
  String name = "Hayat";
  late StreamSubscription<ConnectivityResult> subscription;
  @override
  void initState() {
    super.initState();
    checkcon();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          name = "⚡ Offline";
        });
      } else {
        setState(() {
          name = "Hayat";
        });
      }
    });
  }

  void checkcon() async {
    var result = await Functions.checkConnectivity();
    debugPrint(result.toString());
    if (result == ConnectivityResult.none) {
      setState(() {
        name = "⚡ Offline";
      });
    }
  }

  // Be sure to cancel subscription after you are done
  @override
  dispose() {
    super.dispose();

    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    String? chosenDropdownOption;
    var profileDropdown = DropdownButton(
      hint: _nameAndProfilePicture(
        context,
        name,
        "./assets/avatar.png",
      ),
      elevation: 8,
      value: chosenDropdownOption,
      icon: const Icon(Iconsax.arrow_circle_down),
      borderRadius: BorderRadius.circular(20),
      items: [
        DropdownMenuItem(
          value: "Notifications",
          child: Row(
            children: const [
              Icon(
                Iconsax.notification,
                size: 20,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        DropdownMenuItem(
          value: "Logout",
          child: Row(
            children: const [
              Icon(
                Iconsax.logout,
                size: 20,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      onChanged: (value) {
        setState(
          () {
            chosenDropdownOption = value;
          },
        );
        if (value == "Logout") {
          _authManager.logOut();
        }
        if (value == "Notifications") {
          Get.to(() => const NotificationsPage());
        }
      },
    );

    return Padding(
      padding: Responsive.isMobile(context)
          ? const EdgeInsets.only(top: 32, left: 16, right: 16)
          : const EdgeInsets.all(16.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 112,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              widget.pageName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Responsive.isMobile(context) ? 24 : 36,
              ),
            ),
            DropdownButtonHideUnderline(
              child: profileDropdown,
            ),
          ],
        ),
      ),
    );
  }

  Widget _nameAndProfilePicture(
      BuildContext context, String username, String imageUrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Visibility(
          visible: !Responsive.isMobile(context),
          child: CircleAvatar(
            backgroundImage: AssetImage(imageUrl),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            username,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
