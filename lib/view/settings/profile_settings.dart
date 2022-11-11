import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/controller/language_controller.dart';
import 'package:migo/utils/functions.dart';
import 'package:migo/widgets/buttons.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({
    Key? key,
    required this.fullnameController,
  }) : super(key: key);

  final TextEditingController fullnameController;

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final LanguageController languageController = Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 24),
          LanguageToggle(languageController: languageController),
          const SizedBox(height: 24),
          TextField(
            controller: widget.fullnameController,
            decoration: const InputDecoration(
              label: Text("Full Name"),
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            onPressed: () {
              Functions.launchURL("https://www.mi.com/in/service/");
            },
            buttonTitle: "Change your name",
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            onPressed: () {
              Functions.launchURL("https://www.mi.com/in/service/");
            },
            buttonTitle: "Change password",
            iconRight: const Icon(Iconsax.export_3),
            vertPad: 24,
          ),
        ],
      ),
    );
  }
}

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({
    Key? key,
    required this.languageController,
  }) : super(key: key);

  final LanguageController languageController;

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      initialLabelIndex: GetStorage().read("lan") == "Hindi" ? 1 : 0,
      totalSwitches: 2,
      labels: const ['English', 'हिन्दी'],
      onToggle: (index) {
        debugPrint('switched to: $index');
        if (index == 0) {
          languageController.setLangaugeEnglish();
        }
        if (index == 1) {
          languageController.setLangaugeHindi();
        }
      },
    );
  }
}
