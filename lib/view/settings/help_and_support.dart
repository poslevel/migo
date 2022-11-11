import 'package:flutter/material.dart';
import 'package:migo/utils/functions.dart';
import 'package:migo/widgets/buttons.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 315,
          child: PrimaryButton(
            onPressed: () {
              Functions.launchURL("https://www.mi.com/in/service/");
            },
            buttonTitle: "Reach Mi Help and support service",
          ),
        )
      ],
    );
  }
}
