import 'package:flutter/material.dart';
import 'package:migo/layout/layout.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppLayout(
        activeTab: 5,
        pageName: "Settings",
        content: Row(
          children: [
            InkWell(
              onTap: () {},
              child: Card(
                child: Column(
                  children: const [
                    Text("Settings page"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
