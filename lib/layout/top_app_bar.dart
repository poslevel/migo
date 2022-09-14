import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/view/responsive.dart';

class TopAppBar extends StatefulWidget {
  const TopAppBar({Key? key, required this.pageName}) : super(key: key);

  final String pageName;
  @override
  State<TopAppBar> createState() => _TopAppBarState();
}

class _TopAppBarState extends State<TopAppBar> {
  @override
  Widget build(BuildContext context) {
    String? chosenDropdownOption;
    var profileDropdown = DropdownButton(
      hint: _nameAndProfilePicture(
        context,
        "Hayat",
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
            // print(value);
          },
        );
      },
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
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
            // SizedBox(
            //   width: MediaQuery.of(context).size.width / 3,
            //   child: const TextField(
            //     decoration: InputDecoration(
            //       fillColor: Colors.transparent,
            //       hintText: "Search",
            //       icon: Icon(Iconsax.search_normal),
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(8.0)),
            //         borderSide: BorderSide(color: Colors.transparent),
            //       ),
            //     ),
            //   ),
            // ),
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
